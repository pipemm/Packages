package demo;

import java.io.Writer;
import java.io.IOException;
import java.util.List;
import java.util.ArrayList;
import java.util.Objects;


import software.amazon.awssdk.services.s3.model.CompletedPart;
import software.amazon.awssdk.services.s3.model.CreateMultipartUploadRequest;
import software.amazon.awssdk.services.s3.model.CreateMultipartUploadResponse;
import software.amazon.awssdk.services.s3.model.UploadPartRequest;
import software.amazon.awssdk.services.s3.model.UploadPartResponse;
import software.amazon.awssdk.core.sync.RequestBody;


import demo.S3Tool;

public class S3Writer extends Writer {
    // https://docs.aws.amazon.com/AmazonS3/latest/userguide/mpu-upload-object.html
    // https://docs.aws.amazon.com/code-library/latest/ug/java_2_s3_code_examples.html

    private static final int BUFFER_SIZE_MINIMUM =      5 *1024*1024; // 5 MiB
    private static final int BUFFER_SIZE_MAXIMUM = 5 *1024*1024*1024; // 5 GiB
    private static final int BUFFER_SIZE         = BUFFER_SIZE_MINIMUM;
    private char[]           buffer;
    private int              position;
    private String           bucketName;
    private String           keyName;
    private String           uploadID;
    private List<CompletedPart> completedParts;
    private Integer             partNumber;
    
    public S3Writer(String bucketName, String keyName) {
        CreateMultipartUploadRequest request   = CreateMultipartUploadRequest.builder()
                                                    .bucket(bucketName)
                                                    .key(keyName)
                                                    .build();
        CreateMultipartUploadResponse response = S3Tool.S3Client().createMultipartUpload(request);
        this.uploadID       = response.uploadId();
        this.bucketName     = response.bucket();
        this.keyName        = response.key();

        this.completedParts = new ArrayList<CompletedPart>();
        this.partNumber     = 0;
        this.buffer   = new char[BUFFER_SIZE/2];
        this.position = 0;
    }

    private int min(int a, int b) {
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
        if (uploadID == null) {
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
            String data = new String(buffer,0,position);
            partNumber += 1;
            UploadPartRequest request
                        = UploadPartRequest.builder()
                            .bucket(bucketName)
                            .key(keyName)
                            .uploadId(uploadID)
                            .contentLength((long) data.getBytes().length)
                            .build();
            UploadPartResponse response 
                        = S3Tool.S3Client().uploadPart(
                            request,
                            RequestBody.fromString(data)
                            );
            String eTag = response.eTag();
            completedParts.add(
                CompletedPart.builder()
                    .partNumber(partNumber)
                    .eTag(eTag)
                    .build()
                );
            position = 0;
        }
    }

    private void completeMultipartUpload() {

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
