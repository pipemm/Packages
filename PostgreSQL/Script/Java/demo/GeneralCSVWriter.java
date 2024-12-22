package demo;

import java.nio.file.Paths; 
import java.nio.file.Path; 
import java.io.File;

import java.io.FileWriter;
import java.io.BufferedWriter;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.io.IOException;

import com.opencsv.ICSVWriter;
import com.opencsv.CSVWriterBuilder;
import com.opencsv.CSVWriter;
import com.opencsv.ResultSetHelperService;

import org.supercsv.io.ICsvResultSetWriter;
import org.supercsv.io.CsvResultSetWriter;
import org.supercsv.prefs.CsvPreference;

import demo.IWriter;
//import demo.BufferedWriter; // use the custom BufferedWriter instead of the standard one

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

    private void writeOpenCSV(ResultSet rs) throws SQLException {
        // https://opencsv.sourceforge.net/
        boolean includeColumnNames = true;
        try (
            BufferedWriter out = new BufferedWriter(new FileWriter(file.toString()));
        ) {
            ResultSetHelperService service = new ResultSetHelperService();
            service.setDateFormat("yyyy-MM-dd");
            service.setDateTimeFormat("yyyy-MM-dd HH:mm:ss");
            ICSVWriter csvWriter = 
                new CSVWriterBuilder(out)
                    .withResultSetHelper(service)
                    .build();
            csvWriter.writeAll(rs, includeColumnNames);
            out.flush();
        } catch (IOException e) {
            e.printStackTrace();
            throw new RuntimeException("writer error");
        }
    }

    private void writeSuperCSV(ResultSet rs) throws SQLException {
        // https://super-csv.github.io/super-csv/examples_jdbc.html
        try (
            BufferedWriter out         = new BufferedWriter(new FileWriter(file.toString()));
            ICsvResultSetWriter writer = new CsvResultSetWriter(out, CsvPreference.STANDARD_PREFERENCE);
        ) {
            writer.write(rs);
        } catch (IOException e) {
            e.printStackTrace();
            throw new RuntimeException("writer error");
        }
    }

    public void write(ResultSet rs) throws SQLException {
        writeSuperCSV(rs);
    }

}