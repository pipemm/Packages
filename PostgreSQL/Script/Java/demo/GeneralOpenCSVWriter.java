package demo;

import java.sql.ResultSet;
import java.lang.SecurityManager;

import com.opencsv.CSVWriter;

import demo.IWriter;

public class GeneralOpenCSVWriter implements IWriter {

    public GeneralOpenCSVWriter(String p) {

    }
    
    public int write(ResultSet rs) {
        return 0;
    }

}