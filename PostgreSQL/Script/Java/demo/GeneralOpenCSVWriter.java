package demo;

import java.nio.file.Paths; 
import java.nio.file.Path; 
import java.io.File;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.lang.SecurityManager;
import java.lang.SecurityException;

import com.opencsv.CSVWriter;

import demo.IWriter;

public class GeneralOpenCSVWriter implements IWriter {

    private String filePath;
    private File   file;

    public GeneralOpenCSVWriter(String p) {

        filePath  = p;
        Path path = Paths.get(filePath);
        if( path.getNameCount() == 0 ) {
            throw new IllegalArgumentException("wrong path " + path);
        }
        file = path.toFile();
        
        SecurityManager security = System.getSecurityManager();
        if ( security != null ) {
            security.checkWrite(filePath);
        }


    }
    
    public void write(ResultSet rs) throws SQLException {

        while (rs.next()) {
            System.out.print("Column 1 returned ");
            System.out.println(rs.getString(1));
        }

    }

}