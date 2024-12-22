package demo;

import java.util.Properties;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import software.amazon.awssdk.http.urlconnection.UrlConnectionHttpClient;
import software.amazon.awssdk.services.secretsmanager.SecretsManagerClient;
import software.amazon.awssdk.services.secretsmanager.model.GetSecretValueRequest;

import demo.ConnectionBuilderRDS;

public class ConnectionBuilderRDSDeprecated extends ConnectionBuilderRDS {
// Amazon Relational Database Service (RDS)
// https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.IAMDBAuth.Connecting.Java.html#UsingWithRDS.IAMDBAuth.Connecting.Java.AuthToken

    private static final String 
        ENVIRONMENT_VARIABLE_NAME_DB_USER_SERCET_NAME = "DB_ACOUNT_SECRET_NAME";

    private static String getPassword() {

        String secretName = System.getenv(ENVIRONMENT_VARIABLE_NAME_DB_USER_SERCET_NAME);
        if ( secretName == null ) {
            throw new IllegalArgumentException("secret name is missing");
        }
        
        SecretsManagerClient sm = SecretsManagerClient.builder()
                                    .httpClientBuilder(UrlConnectionHttpClient.builder())
                                    .build();

        GetSecretValueRequest request = GetSecretValueRequest.builder()
                                            .secretId(secretName)
                                            .build();

        return sm.getSecretValue(request).secretString();
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