package demo;

import java.io.Writer;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.io.IOException;
//import java.io.BufferedWriter;

import com.opencsv.ICSVWriter;
import com.opencsv.CSVWriterBuilder;
import com.opencsv.CSVWriter;
import com.opencsv.ResultSetHelperService;

import org.supercsv.io.ICsvResultSetWriter;
import org.supercsv.io.CsvResultSetWriter;
import org.supercsv.prefs.CsvPreference;
//import demo.BufferedWriter; // use the custom BufferedWriter instead of the standard one

public class WriterCSVHelper {

    public static void writeOpenCSV(ResultSet rs, Writer w) throws SQLException, IOException {
        // https://opencsv.sourceforge.net/
        boolean includeColumnNames = true;
        ResultSetHelperService service = new ResultSetHelperService();
        service.setDateFormat("yyyy-MM-dd");
        service.setDateTimeFormat("yyyy-MM-dd HH:mm:ss");
        try (
        ICSVWriter csvWriter = 
            new CSVWriterBuilder(w)
                .withResultSetHelper(service)
                .build();
        ) {
            csvWriter.writeAll(rs, includeColumnNames);
        }
        //w.flush();
    }

    public static void writeSuperCSV(ResultSet rs, Writer w) throws SQLException, IOException {
        // https://super-csv.github.io/super-csv/examples_jdbc.html
        try (
            ICsvResultSetWriter writer = new CsvResultSetWriter(w, CsvPreference.STANDARD_PREFERENCE);
        ) {
            writer.write(rs);
        }
    }

}