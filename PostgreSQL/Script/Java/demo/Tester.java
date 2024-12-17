package demo;

import java.sql.Connection;
import java.sql.SQLException;

import demo.GeneralReader;
import demo.ConnectionBuilderPostgreSQL;

public class Tester {
    
    private static String getSQL(String path) {
        
        if ( ! path.matches("^.*\\.sql$") ) {
           throw new IllegalArgumentException("SQL file name should end with .sql: " + path);
        }

        GeneralReader reader = new GeneralReader(path);

        return reader.getContent();

    }

    public static void main(String[] args) {

        Connection conn = null;

        try {
            
            if ( args.length < 1 ) {
                System.err.println("needs a script.");
                return;
            }

            String pathScript = args[0];
            String sql        = getSQL(pathScript);

            System.out.println(sql);

            // Establish the connection
            conn = ConnectionBuilderPostgreSQL.getConnection();
            System.out.println("Connection established successfully.");

        } catch (SQLException | IllegalArgumentException e) {

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
