package demo;

import java.io.IOException;

import java.time.Instant;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;

import java.sql.Connection;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;

import demo.ReaderInterface;
import demo.GeneralReader;

import demo.WriterInterface;
import demo.GeneralOpenCSVWriter;

import demo.ConnectionBuilderPostgreSQL;

public class Tester {

    private static final String outputDefault = "ResultSet.csv";

    private static ReaderInterface reader = null;
    
    private static ReaderInterface getReader(String path) {
        
        path = path.trim();

        if ( ! path.matches("^.*\\.sql$") ) {
           throw new IllegalArgumentException("SQL file name should end with .sql (" + path + ")");
        }

        ReaderInterface reader = new GeneralReader(path);

        return reader;

    }

    private static WriterInterface getWriter(String path) {

        path = path.trim();

        ZonedDateTime utcNow        = Instant.now().atZone(ZoneId.of("UTC"));
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
        String formattedDateTime    = utcNow.format(formatter);

        String outPath = outputDefault;

        if ( path == null & ( reader == null | reader.getBaseName().length() == 0 ) ) {

        }

        WriterInterface writer = new GeneralOpenCSVWriter(path);

        return writer;

    }

    public static void main(String[] args) {

        try {
            if ( args.length < 1 ) {
                System.err.println("needs a script.");
                return;
            }
            String pathScript = args[0];
            reader            = getReader(pathScript);
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
        }

        try (
            Connection conn = ConnectionBuilderPostgreSQL.getConnection();
            Statement  st   = conn.createStatement()
        ){
            System.out.println("connection established");

            String sql = reader.getContent();

            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                System.out.print("Column 1 returned ");
                System.out.println(rs.getString(1));
            }
        } catch (SQLException | IOException e) {
            e.printStackTrace();
        } 

    }

}
