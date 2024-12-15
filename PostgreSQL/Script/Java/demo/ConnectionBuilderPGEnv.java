package demo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionBuilderPGEnv {

    public static Connection getConnection() throws SQLException {

        Connection connection = null;
        String     url        = null;
        
        url = System.getenv("PG_SERVER_URL");
        if ( url == null ) {
            throw new IllegalArgumentException("URL is missing.");
        }

        connection = DriverManager.getConnection(url);

        return connection;
    }

    // for testing
    public static void main(String[] args) {

        Connection connection = null;

        try {

            // Establish the connection
            connection = getConnection();
            System.out.println("Connection established successfully.");

        } catch (SQLException | IllegalArgumentException e) {

            e.printStackTrace();

        } finally {

            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }

    }
}
