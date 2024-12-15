package demo;

import java.sql.Connection;

public class ConnectionBuilderPGEnv {

    public static Connection getConnection() {

        Connection connection = null;

        String url = null;
        
        url = System.getenv("PG_SERVER_URL");
        if ( url == null ) {
            System.err.println("URK is missing.");
            System.exit(1);
        }

        return connection;
    }

    // for testing
    public static void main(String[] args) {

        Connection connection = getConnection();

    }
}
