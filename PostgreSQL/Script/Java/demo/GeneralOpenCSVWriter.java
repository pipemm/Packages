package demo;

import java.nio.file.Paths; 
import java.nio.file.Path; 
import java.io.File;

import java.sql.ResultSet;
import java.lang.SecurityManager;

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
        if ( ! file.canWrite() ) {
            throw new IllegalArgumentException("cannot write " + path);
        }

    }
    
    public void write(ResultSet rs) {
        return;
    }

}