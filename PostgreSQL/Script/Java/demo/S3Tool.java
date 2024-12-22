package demo;

import java.net.URI;

import software.amazon.awssdk.http.urlconnection.UrlConnectionHttpClient;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.S3Uri;

public class S3Tool {

    private static S3Client s3;
    
    public static S3Client S3Client() {
        if ( s3 == null ) {
            s3 = S3Client.builder()
                .httpClientBuilder(UrlConnectionHttpClient.builder())
                .build();
        } 
        if ( s3 == null ) {
            throw new RuntimeException("[ERROR] S3 Client");
        }
        return s3;
    }
    
    public static S3Uri parseS3Uri(String path) {
        // https://docs.aws.amazon.com/AmazonS3/latest/API/s3_example_s3_Scenario_URIParsing_section.html
        // https://docs.aws.amazon.com/sdk-for-java/latest/developer-guide/http-configuration.html
        return S3Client().utilities().parseUri(URI.create(path));
        // to do check the validity of URI here, instead of the downstream processes.
    }

}