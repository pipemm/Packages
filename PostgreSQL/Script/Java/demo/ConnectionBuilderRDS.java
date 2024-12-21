package demo;

import java.util.Properties;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import software.amazon.awssdk.services.rds.RdsClient;
import software.amazon.awssdk.http.urlconnection.UrlConnectionHttpClient;
import software.amazon.awssdk.services.rds.model.GenerateAuthenticationTokenRequest;

import demo.ConnectionBuilder;

public class ConnectionBuilderRDS extends ConnectionBuilder {
// Amazon Relational Database Service (RDS)
// https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.IAMDBAuth.Connecting.Java.html#UsingWithRDS.IAMDBAuth.Connecting.Java.AuthToken

    protected static String getHostname(){
        String hostname = ConnectionBuilder.getHostname();
        if ( hostname == null ) {
            throw new IllegalArgumentException("hostname is missing");
        }
        return hostname;
    }

    private static String getPassword() {

        String host = getHostname();
        int    port = getPort();
        String user = getUsername();
        GenerateAuthenticationTokenRequest request = 
            GenerateAuthenticationTokenRequest.builder()
                .hostname(host)
                .port(port)
                .username(user)
                .build();
        
        RdsClient rds = 
            RdsClient.builder()
                .httpClientBuilder(UrlConnectionHttpClient.builder())
                .build();

        return rds.utilities().generateAuthenticationToken(request);
    }

    protected static String getURL() {
        
        String host = getHostname();
        String port = String.valueOf(getPort());
        if ( port != null ) {
            host += ":" + port;
        }
        String dbName = getDabaseName();
        if ( dbName == null ) {
            dbName = "";
        }
        
        return "jdbc:postgresql://" + host + "/" + dbName;
    }

    public static Connection getConnection() throws SQLException {

        String url = getURL();
        
        Properties props = new Properties();
        props.setProperty("user",     getUsername());
        props.setProperty("password", getPassword());
        props.setProperty("sslmode",  getSSLMode());
        
        return DriverManager.getConnection(url, props);
    }

}