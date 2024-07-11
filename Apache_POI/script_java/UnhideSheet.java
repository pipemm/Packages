import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook; // For XLSX files

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

public class UnhideSheet {
    public static void main(String[] args) {
        if (args.length != 2) {
            System.err.println("Usage: java UnhideSheet <inputFile> <outputFile>");
            System.exit(1);
        }
        String inputFile  = args[0]; // Input Excel file
        String outputFile = args[1]; // Output Excel file

        // Exception in thread "main" java.lang.OutOfMemoryError: Java heap space
        try (Workbook workbook = new XSSFWorkbook(inputFile)) { // Use XSSFWorkbook for XLSX files
            System.out.println(workbook.getNumberOfSheets());
            for (int sheetIndex = 0; sheetIndex < workbook.getNumberOfSheets(); sheetIndex+=1) {
                SheetVisibility visibility =  workbook.getSheetVisibility(sheetIndex);
                
                if ( visibility != SheetVisibility.VISIBLE ) {
                    workbook.setSheetVisibility(sheetIndex, SheetVisibility.VISIBLE);
                }
            }

            // Save changes to the output file
            try (FileOutputStream fos = new FileOutputStream(outputFile)) {
                workbook.write(fos);
            }
            System.out.println("Hidden rows unhidden successfully!");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
