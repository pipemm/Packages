package demo;

import java.nio.file.Paths; 
import java.nio.file.Path; 
import java.io.File;
import java.io.IOException;

import java.io.FileWriter;
//import java.io.BufferedWriter;

import java.sql.ResultSet;
import java.sql.SQLException;

import demo.WriterCSVHelper;
import demo.IWriter;
import demo.BufferedWriter; // use the custom BufferedWriter instead of the standard one

public class GeneralCSVWriter implements IWriter {

    private File file;

    public GeneralCSVWriter(String p) {
        String filePath = p;
        Path path       = Paths.get(filePath);
        if( path.getNameCount() == 0 ) {
            throw new IllegalArgumentException("wrong path " + path);
        }
        file = path.toFile();
    }

    public void write(ResultSet rs) throws SQLException {
        try {
            BufferedWriter out = new BufferedWriter(new FileWriter(file.toString()));
            WriterCSVHelper.writeSuperCSV(rs,out);
        } catch (IOException e) {
            e.printStackTrace();
            throw new RuntimeException("writer error");
        }
    }

}