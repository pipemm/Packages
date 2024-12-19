package demo;

import java.util.Properties;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import software.amazon.awssdk.services.rds.RdsClient;
import software.amazon.awssdk.http.urlconnection.UrlConnectionHttpClient;
import software.amazon.awssdk.services.rds.model.GenerateAuthenticationTokenRequest;

import demo.ConnectionBuilderPostgreSQL;

public class ConnectionBuilderRDSDispatching extends ConnectionBuilderRDS {
// Amazon Relational Database Service (RDS)
// https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.IAMDBAuth.Connecting.Java.html#UsingWithRDS.IAMDBAuth.Connecting.Java.AuthToken

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