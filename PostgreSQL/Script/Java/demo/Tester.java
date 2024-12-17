package demo;

import java.sql.Connection;
import java.sql.SQLException;

import demo.ConnectionBuilderPostgreSQL;

public class Tester {
    
    private static String getSQL(String path) {
        
        if ( ! path.endsWith(".sql") ) {
           throw IllegalArgumentException("SQL file should end with .sql.");
        }

        return path;

    }

    public static void main(String[] args) {

        Connection conn = null;

        try {
            
            System.out.println(args.length);

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
