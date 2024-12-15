package demo;

import java.sql.Connection;
import java.sql.SQLException;

import demo.ConnectionBuilderPostgreSQL;

public class Tester {
    
    // for testing
    public static void main(String[] args) {

        Connection conn = null;

        try {

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
