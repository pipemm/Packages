package demo;

import java.io.IOException;

import java.sql.Connection;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;

import demo.ReaderInterface;
import demo.GeneralReader;

import demo.ConnectionBuilderPostgreSQL;

public class Tester {

    private static final String outputDefault = "ResultSet.csv";

    private static ReaderInterface reader = null;
    
    private static ReaderInterface getReader(String path) {
        
        if ( ! path.matches("^.*\\.sql$") ) {
           throw new IllegalArgumentException("SQL file name should end with .sql (" + path + ")");
        }

        ReaderInterface reader = new GeneralReader(path);

        return reader;

    }

    public static void main(String[] args) {

        try {
            if ( args.length < 1 ) {
                System.err.println("needs a script.");
                return;
            }
            String pathScript = args[0];
            reader            = getReader(pathScript);
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
        }

        try (
            Connection conn = ConnectionBuilderPostgreSQL.getConnection();
            Statement  st   = conn.createStatement()
        ){
            System.out.println("connection established");

            String sql = reader.getContent();

            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                System.out.print("Column 1 returned ");
                System.out.println(rs.getString(1));
            }
        } catch (SQLException | IOException e) {
            e.printStackTrace();
        } 

    }

}
