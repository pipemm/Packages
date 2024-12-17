package demo;

import java.io.IOException;

import java.sql.Connection;
import java.sql.SQLException;

import demo.ReaderInterface;
import demo.GeneralReader;

import demo.ConnectionBuilderPostgreSQL;

public class Tester {

    private static ReaderInterface reader = null;
    
    private static ReaderInterface getReader(String path) {
        
        if ( ! path.matches("^.*\\.sql$") ) {
           throw new IllegalArgumentException("SQL file name should end with .sql (" + path + ")");
        }

        ReaderInterface reader = new GeneralReader(path);

        return reader;

    }

    public static void main(String[] args) {

        Connection conn = null;

        try {
            
            if ( args.length < 1 ) {
                System.err.println("needs a script.");
                return;
            }

            String pathScript = args[0];
            reader            = getReader(pathScript);
            String sql        = reader.getContent();

            System.out.println(sql);

            // Establish the connection
            conn = ConnectionBuilderPostgreSQL.getConnection();
            System.out.println("Connection established successfully.");

        } catch (SQLException | IllegalArgumentException | IOException e) {

            e.printStackTrace();

        } finally {

            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }

        }

    }

}
