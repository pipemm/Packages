package demo;

import java.io.Writer;
import java.io.IOException;
import java.util.List;
import java.util.ArrayList;
import java.util.Objects;
import java.nio.charset.Charset;
import java.nio.CharBuffer;
import java.nio.ByteBuffer;

import software.amazon.awssdk.services.s3.model.CompletedPart;
import software.amazon.awssdk.services.s3.model.CreateMultipartUploadRequest;
import software.amazon.awssdk.services.s3.model.CreateMultipartUploadResponse;
import software.amazon.awssdk.services.s3.model.UploadPartRequest;
import software.amazon.awssdk.services.s3.model.UploadPartResponse;
import software.amazon.awssdk.services.s3.model.CompleteMultipartUploadRequest;
import software.amazon.awssdk.services.s3.model.CompletedMultipartUpload;
import software.amazon.awssdk.core.sync.RequestBody;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import demo.S3Tool;

public class S3Writer extends Writer {
    // https://docs.aws.amazon.com/code-library/latest/ug/java_2_s3_code_examples.html
    
    private static final Logger logger = LoggerFactory.getLogger(S3Writer.class);
    private static final int BUFFER_SIZE_MINIMUM =      5 *1024*1024; // 5 MiB
    private static final int BUFFER_SIZE_MAXIMUM = 5 *1024*1024*1024; // 5 GiB
    private static final int BUFFER_SIZE         = BUFFER_SIZE_MINIMUM;
    private char[] buffer;
    private int    position;
    private String bucketName;
    private String keyName;
    private String              uploadID;
    private List<CompletedPart> completedParts;
    private int                 partNumber;
    
    public S3Writer(String bucketName, String keyName) {
        createUpload(bucketName, keyName);
        this.buffer   = new char[BUFFER_SIZE];
        this.position = 0;
    }

    private RequestBody getRequestBody() {
    // encodeArrayLoop
    // https://github.com/corretto/corretto-21/blob/develop/src/java.base/share/classes/sun/nio/cs/UTF_8.java
        CharBuffer charBuffer = CharBuffer.wrap(buffer,0,position);
        ByteBuffer byteBuffer = Charset.forName("UTF-8").encode(charBuffer);
        return RequestBody.fromRemainingByteBuffer(byteBuffer);
    }

    private void createUpload(String bucketName, String keyName) {
        CreateMultipartUploadRequest request
                            = CreateMultipartUploadRequest.builder()
                                .bucket(bucketName)
                                .key(keyName)
                                .build();
        logger.info( "CreateMultipartUpload request sending" );
        CreateMultipartUploadResponse response 
                            = S3Tool.S3Client().createMultipartUpload(request);
        this.uploadID       = response.uploadId();
        this.bucketName     = response.bucket();
        this.keyName        = response.key();
        logger.info( "CreateMultipartUpload responded" );
        logger.info( "upload id: " + this.uploadID );
        logger.info( "s3 object: " + S3Tool.getS3URL(bucketName,keyName) );
        this.completedParts = new ArrayList<CompletedPart>();
        this.partNumber     = 0;
    }

    private static int min(int a, int b) {
        if (a < b) {
            return a;
        }
        return b;
    }

    private void ensureOpen() throws IOException {
        if (uploadID == null) {
            throw new IOException("Stream closed");
        }
    }

    public void write(char[] cbuf, int off, int len) throws IOException {
        ensureOpen();
        if (cbuf == null) {
            throw new NullPointerException();
        }
        Objects.checkFromIndexSize(off, len, cbuf.length);

        int coff = off;
        int clen = len;
        while (clen > 0) {
            int spaceLeft = buffer.length - position;
            int lenToCopy = min(clen, spaceLeft);
            System.arraycopy(cbuf, coff, buffer, position, lenToCopy);
            position += lenToCopy;
            coff     += lenToCopy;
            clen     -= lenToCopy;

            if (position == buffer.length) {
                flushBuffer();
            }
        }
    }

    public void flush() throws IOException {
        ensureOpen();
        if (position == buffer.length) {
            flushBuffer();
        }
    }

    private void flushBuffer() throws IOException {
        if (position > 0) {
            partNumber += 1;
            RequestBody data = getRequestBody();
            UploadPartRequest request
                        = UploadPartRequest.builder()
                            .bucket(bucketName)
                            .key(keyName)
                            .uploadId(uploadID)
                            .partNumber(partNumber)
                            .build();
            logger.info( "UploadPart request sending" );
            logger.info( "part: " + partNumber );
            UploadPartResponse response 
                        = S3Tool.S3Client().uploadPart(request,data);
            String eTag = response.eTag();
            completedParts.add(
                CompletedPart.builder()
                    .partNumber(partNumber)
                    .eTag(eTag)
                    .build()
                );
            logger.info( "UploadPart responded" );
            logger.info( "ETag: " + eTag );
            position = 0;
        }
    }

    private void completeMultipartUpload() {
        CompletedMultipartUpload completedUpload 
                        = CompletedMultipartUpload.builder()
                            .parts(completedParts)
                            .build();
        CompleteMultipartUploadRequest request 
                        = CompleteMultipartUploadRequest.builder()
                            .bucket(bucketName)
                            .key(keyName)
                            .uploadId(uploadID)
                            .multipartUpload(completedUpload)
                            .build();
        logger.info( "upload id: " + uploadID );
        logger.info( "CompletedMultipartUpload request sending" );
        S3Tool.S3Client().completeMultipartUpload(request);
        logger.info( "CompletedMultipartUpload responded" );
        logger.info( "s3 object: " + S3Tool.getS3URL(bucketName,keyName) );
    }

    public void close() throws IOException {
        if (uploadID == null) {
            return;
        }
        try {
            flushBuffer();
            completeMultipartUpload();
        } finally {
            uploadID       = null;
            buffer         = null;
            completedParts = null;
        }
    }
}
