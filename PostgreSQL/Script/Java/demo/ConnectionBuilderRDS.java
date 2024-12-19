package demo;

import java.sql.Connection;

public class ConnectionBuilderRDS {
// Amazon Relational Database Service (RDS)
// https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.IAMDBAuth.Connecting.Java.html#UsingWithRDS.IAMDBAuth.Connecting.Java.AuthToken

    private static final String ENVIRONMENT_VARIABLE_NAME_DB_SERVER_HOSTNAME  = "RDS_SERVER_HOSTNAME";
    private static final String ENVIRONMENT_VARIABLE_NAME_DB_SERVER_PORT      = "RDS_SERVER_PORT";
    private static final String ENVIRONMENT_VARIABLE_NAME_DB_ACCOUNT_USERNAME = "RDS_ACOUNT_USER";

    public static Connection getConnection() {

        Connection conn  = null;
        return conn;

    }

}