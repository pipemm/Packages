package demo;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import software.amazon.awssdk.services.s3.S3Uri;

import demo.IWriter;
import demo.S3Tool;
import demo.S3Writer;

public class S3CSVWriter implements IWriter {

    private String bucket;
    private String key;

    public S3CSVWriter(String p) {
        String filePath = p;
        S3Uri  uri      = S3Tool.parseS3Uri(filePath);
        bucket = uri.bucket()
                    .orElseThrow(() -> new IllegalArgumentException("S3 Bucket not presented: " + filePath));
        key    = uri.key()
                    .orElseThrow(() -> new IllegalArgumentException("S3 Key not presented: "    + filePath));
    }

    public void write(ResultSet rs) throws SQLException {
        try {
            S3Writer out = new S3Writer(bucket, key);
            WriterCSVHelper.writeSuperCSV(rs,out);
        } catch (IOException e) {
            e.printStackTrace();
            throw new RuntimeException("writer error");
        }
    }

}
