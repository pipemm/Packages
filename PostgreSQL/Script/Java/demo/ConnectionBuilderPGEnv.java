package demo;

import java.util.Properties;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionBuilderPGEnv {

    private static Connection getConnectionTry(
            String url, 
            String user, 
            String pass
            ) throws SQLException {

        Connection connection = null;
        Properties props = new Properties();
        props.setProperty("ssl", "true");

        if ( user != null & pass != null) {
            props.setProperty("user",     user);
            props.setProperty("password", pass);
            try {
                connection = DriverManager.getConnection(url,props);
            } catch (SQLException e) {
                props = new Properties();
                props.setProperty("ssl", "true");
                try {
                    connection = DriverManager.getConnection(url,props);
                } catch (SQLException ne) {
                    throw e;
                }
            }
        } else {
            connection = DriverManager.getConnection(url,props);
        }

        return connection;
    }

    public static Connection getConnection() throws SQLException {

        Connection connection = null;
        String     url        = null;
        String     user       = null;
        String     pass       = null;
        
        url = System.getenv("PG_SERVER_URL");
        if ( url == null ) {
            throw new IllegalArgumentException("URL is missing.");
        }
        user = System.getenv("PG_ACOUNT_USER");
        pass = System.getenv("PG_ACOUNT_PASSWORD");

        connection = getConnectionTry(url, user, pass);

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
