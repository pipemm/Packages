
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.FileOutputStream;
import java.io.OutputStream;

// [New Workbook](https://poi.apache.org/components/spreadsheet/quick-guide.html#NewWorkbook)
public class NewWorkbook {
    public static void main(String[] args) {
        if (args.length < 1) {
            System.out.println("Usage: java NewWorkbook <file-path>");
            return;
        }

        String filePath = args[0];
        
        Workbook wb  = new XSSFWorkbook();
        Sheet sheet1 = wb.createSheet("Sheet1");
        try (OutputStream fileOut = new FileOutputStream(filePath)) {
            wb.write(fileOut);
            System.out.println("Workbook created successfully at: " + filePath);
        } catch (Exception e) {
            System.out.println("Error creating workbook: " + e.getMessage());
        } finally {
            try {
                wb.close();
            } catch (Exception e) {
                System.out.println("Error closing workbook: " + e.getMessage());
            }
        }
    }
}
