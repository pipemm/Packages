package demo;

import java.sql.ResultSet;
import java.lang.SecurityManager;

import com.opencsv.CSVWriter;

public class GeneralOpenCSVWriter implements WriterInterface {

    public GeneralOpenCSVWriter(String p) {

    }
    
    public int write(ResultSet rs) {
        return 0;
    }

}