package demo;

import java.util.Properties;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import software.amazon.awssdk.services.rds.RdsClient;
import software.amazon.awssdk.http.urlconnection.UrlConnectionHttpClient;
import software.amazon.awssdk.services.rds.model.GenerateAuthenticationTokenRequest;

import demo.ConnectionBuilderPostgreSQL;

public class ConnectionBuilderRDS extends ConnectionBuilderPostgreSQL {
// Amazon Relational Database Service (RDS)
// https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.IAMDBAuth.Connecting.Java.html#UsingWithRDS.IAMDBAuth.Connecting.Java.AuthToken

    private static final String ENVIRONMENT_VARIABLE_NAME_DB_SERVER_HOSTNAME  = "RDS_SERVER_HOSTNAME";
    private static final String ENVIRONMENT_VARIABLE_NAME_DB_ACCOUNT_USERNAME = "RDS_ACOUNT_USER";

    protected static String getHostname() {
        String hostname = System.getenv(ENVIRONMENT_VARIABLE_NAME_DB_SERVER_HOSTNAME);
        if ( hostname == null ) {
            throw new IllegalArgumentException("hostname is missing");
        }
        return hostname;
    }

    protected static String getURL() {
        String host = getHostname();
        if ( host == null ) {
            throw new IllegalArgumentException("URL or host is missing.");
        }
        Integer port = getPort();
        if ( port > 0 ) {
            host += ":" + port;
        }
        return "jdbc:postgresql://" + host + "/";
    }
    
    protected static String getUsername() {
        String username = System.getenv(ENVIRONMENT_VARIABLE_NAME_DB_ACCOUNT_USERNAME);
        if ( username == null ) {
            throw new IllegalArgumentException("username is missing");
        }
        return username;
    }

    private static String getPassword() {

        String  host = getHostname();
        Integer port = getPort();
        String  user = getUsername();
        GenerateAuthenticationTokenRequest request 
            = GenerateAuthenticationTokenRequest.builder()
                .hostname (host)
                .port     (port)
                .username (user)
                .build();
        
        RdsClient rds 
            = RdsClient.builder()
                .httpClientBuilder(UrlConnectionHttpClient.builder())
                .build();

        return rds.utilities().generateAuthenticationToken(request);
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