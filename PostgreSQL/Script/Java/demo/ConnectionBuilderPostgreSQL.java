package demo;

import java.util.Properties;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionBuilderPostgreSQL {
// https://jdbc.postgresql.org/documentation/use/#connection-parameters

    private static final String ENVIRONMENT_VARIABLE_NAME_DB_SERVER_URL       = "PG_SERVER_URL";
    private static final String ENVIRONMENT_VARIABLE_NAME_DB_SERVER_HOSTNAME  = "PG_SERVER_HOSTNAME";
    private static final String ENVIRONMENT_VARIABLE_NAME_DB_ACCOUNT_USERNAME = "PG_ACOUNT_USER";
    private static final String ENVIRONMENT_VARIABLE_NAME_DB_ACCOUNT_PASSWORD = "PG_ACOUNT_PASSWORD";

    private static final Integer PORT_DEFAULT     = 5432;
    private static final String  SSL_MODE_DEFAULT = "require";

    private static String getHostname() {
        return System.getenv(ENVIRONMENT_VARIABLE_NAME_DB_SERVER_HOSTNAME);
    }
    
    protected static Integer getPort() {
        return PORT_DEFAULT;
    }

    protected static String getURL() {
        String url  = System.getenv(ENVIRONMENT_VARIABLE_NAME_DB_SERVER_URL);
        String host = getHostname();
        if ( url == null ) {
            if ( host == null ) {
                throw new IllegalArgumentException("URL or host is missing.");
            }
            Integer port = getPort();
            if ( port > 0 & port != PORT_DEFAULT ) {
                host += ":" + port;
            }
            url = "jdbc:postgresql://" + host + "/";
        }
        return url;
    }

    protected static String getUsername() {
        String username = System.getenv(ENVIRONMENT_VARIABLE_NAME_DB_ACCOUNT_USERNAME);
        if ( username == null ) {
            throw new IllegalArgumentException("username is missing");
        }
        return username;
    }

    private static String getPassword() {
        String pass = System.getenv(ENVIRONMENT_VARIABLE_NAME_DB_ACCOUNT_PASSWORD);
        if ( pass == null ) {
            throw new IllegalArgumentException("password is missing");
        }
        return pass;
    }

    protected static String getSSLMode() {
        return SSL_MODE_DEFAULT;
    }

    public static Connection getConnection() {

        String url = getURL();
        
        Properties props = new Properties();
        props.setProperty("user",     getUsername());
        props.setProperty("password", getPassword());
        props.setProperty("sslmode",  getSSLMode());
        
        try {
            return DriverManager.getConnection(url, props);
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("database connection not established");
        }

    }

}
