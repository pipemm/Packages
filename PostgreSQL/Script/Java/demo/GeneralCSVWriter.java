package demo;

import java.nio.file.Paths; 
import java.nio.file.Path; 
import java.io.File;

import java.io.FileWriter;
import java.io.BufferedWriter;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.lang.SecurityManager;
import java.lang.SecurityException;
import java.io.IOException;

import com.opencsv.ICSVWriter;
import com.opencsv.CSVWriterBuilder;
import com.opencsv.CSVWriter;

import demo.IWriter;

public class GeneralCSVWriter implements IWriter {

    private File file;

    public GeneralCSVWriter(String p) {

        String filePath = p;
        Path path       = Paths.get(filePath);
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
        boolean includeColumnNames = true;
        try (
            BufferedWriter out = new BufferedWriter(new FileWriter(file.toString()));
        ) {
            ICSVWriter csvWriter = new CSVWriterBuilder(out).build();
            csvWriter.writeAll(rs, includeColumnNames);
            //out.flush();
        } catch (IOException e) {
            e.printStackTrace();
            throw new RuntimeException("writer error");
        }
    }

}