package demo;

import java.net.URI;
import java.nio.charset.StandardCharsets;

import software.amazon.awssdk.http.urlconnection.UrlConnectionHttpClient;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.S3Uri;
import software.amazon.awssdk.services.s3.model.HeadObjectRequest;
import software.amazon.awssdk.services.s3.model.GetObjectRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import demo.IReader;
import demo.S3Tool;

public class S3Reader implements IReader {
    
    private static final Logger logger = LoggerFactory.getLogger(S3Reader.class);
    private String bucket;
    private String key;
    private String baseName;
    
    private Void setBaseName(String p) {
        String filename = p;
        if ( filename.contains("/") ) {
            filename = filename.substring(p.lastIndexOf('/') + 1);
        }
        if ( filename.matches("^[^.]+[.][^.]+$") ) {
            baseName = filename.replaceFirst("[.][^.]+$", "");
        } else {
            baseName = filename;
        }
        return null;
    }
    
    public S3Reader(String p) {  
        String filePath = p;

        S3Uri uri = S3Tool.parseS3Uri(filePath);
        bucket = uri.bucket()
                    .orElseThrow(() -> new IllegalArgumentException("S3 Bucket not presented: " + filePath));
        key    = uri.key()
                    .orElseThrow(() -> new IllegalArgumentException("S3 Key not presented: "    + filePath));
        
        HeadObjectRequest request   = HeadObjectRequest.builder()
            .bucket(bucket)
            .key(key)
            .build();

        S3Tool.S3Client().headObject(request);
        logger.info( "can read s3 object: " + uri.uri().toString() );
        
        setBaseName(key);
    }  
    
    public String getBaseName() {
        return baseName;
    }

    public String getContent() {
        // https://docs.aws.amazon.com/AmazonS3/latest/API/s3-directory-buckets_example_s3-directory-buckets_GetObject_section.html
        GetObjectRequest request = GetObjectRequest.builder()
            .bucket(bucket)
            .key(key)
            .build();
        
        byte[] data = S3Tool.S3Client().getObjectAsBytes(request).asByteArray();
        
        return new String(data, StandardCharsets.UTF_8);
    }

}