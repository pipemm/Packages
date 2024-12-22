package demo;

import java.io.Writer;

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

public class WriterCSVHelper {

    private static void writeOpenCSV(ResultSet rs, Writer w) throws SQLException {
        // https://opencsv.sourceforge.net/
        boolean includeColumnNames = true;
        try {
            ResultSetHelperService service = new ResultSetHelperService();
            service.setDateFormat("yyyy-MM-dd");
            service.setDateTimeFormat("yyyy-MM-dd HH:mm:ss");
            ICSVWriter csvWriter = 
                new CSVWriterBuilder(w)
                    .withResultSetHelper(service)
                    .build();
            csvWriter.writeAll(rs, includeColumnNames);
        } catch (IOException e) {
            e.printStackTrace();
            throw new RuntimeException("writer error");
        }
    }

    private static void writeSuperCSV(ResultSet rs, Writer w) throws SQLException {
        // https://super-csv.github.io/super-csv/examples_jdbc.html
        try {
            ICsvResultSetWriter writer = new CsvResultSetWriter(w, CsvPreference.STANDARD_PREFERENCE);
            writer.write(rs);
        } catch (IOException e) {
            e.printStackTrace();
            throw new RuntimeException("writer error");
        }
    }

}