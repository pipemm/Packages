package demo;

import java.util.Properties;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionBuilderPGEnv {
// https://jdbc.postgresql.org/documentation/use/#connection-parameters

    public static Connection getConnection() throws SQLException {

        Connection conn  = null;
        String     url   = null;
        String     user  = null;
        String     pass  = null;
        Properties props = new Properties();
        
        url = System.getenv("PG_SERVER_URL");
        if ( url == null ) {
            throw new IllegalArgumentException("URL is missing.");
        }
        user = System.getenv("PG_ACOUNT_USER");
        if ( user != null) {
            props.setProperty("user",     user);
        }
        pass = System.getenv("PG_ACOUNT_PASSWORD");
        if ( pass != null ) {
            props.setProperty("password", pass);
        }
        props.setProperty("sslmode", "require");

        conn = DriverManager.getConnection(url,props);

        return conn;
    }

}
