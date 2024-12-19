package demo;

import java.nio.file.Paths; 
import java.io.IOException;

import java.time.Instant;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;

import java.sql.Connection;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;

import demo.IReader;
import demo.GeneralReader;

import demo.IWriter;
import demo.GeneralOpenCSVWriter;

import demo.ConnectionBuilderPostgreSQL;

public class Tester {

    private static final String outputBaseDefault = "ResultSet";

    private static IReader reader = null;
    private static IWriter writer = null;
    
    private static IReader getReader(String path) {
        
        path = path.trim();

        if ( ! path.matches("(?i)^.+\\.sql$") ) {
           throw new IllegalArgumentException("SQL file name should end with .sql (" + path + ")");
        }

        return new GeneralReader(path);

    }

    private static IWriter getWriter(String path) {

        if ( path == null ) {
            path = "";
        }

        path = path.trim();

        ZonedDateTime utcNow        = Instant.now().atZone(ZoneId.of("UTC"));
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmssSSS");
        String formattedDateTime    = utcNow.format(formatter);

        if ( ! path.matches("(?i)^.+\\.csv$") ) {
            String baseName = ( reader==null | reader.getBaseName().length()==0 )? outputBaseDefault:reader.getBaseName();
            path     = Paths.get(path, baseName + "_" + formattedDateTime + ".csv").toString();
        }

        IWriter writer = new GeneralOpenCSVWriter(path);
        System.out.println(path);

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
            

            String pathOut = null;
            if ( args.length >= 2 ) {
                pathOut = args[1];
            }
            writer = getWriter(pathOut);

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
        } catch (SQLException e) {
            e.printStackTrace();
        } 

    }

}
