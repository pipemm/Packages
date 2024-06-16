import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.poifs.crypt.Decryptor;
import org.apache.poi.poifs.crypt.EncryptionInfo;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.FileInputStream;
import java.io.InputStream;
import java.io.IOException;

public class DetermineEncryptionMethod {

    public static void main(String[] args) {
        if (args.length != 1) {
            System.out.println("Usage: java DetermineEncryptionMethod <filename>");
            return;
        }

        String filename = args[0];

        try (FileInputStream fis = new FileInputStream(filename);
             POIFSFileSystem fs = new POIFSFileSystem(fis)) {

            EncryptionInfo info = new EncryptionInfo(fs);
            Decryptor decryptor = Decryptor.getInstance(info);

            // Print encryption details
            System.out.println("Encryption Mode: " + info.getEncryptionMode());
            System.out.println("Hash Algorithm: " + info.getVerifier().getHashAlgorithm());
            System.out.println("Key Size: " + info.getHeader().getKeySize() + " bits");

            // Attempt to decrypt the document (you will need the correct password for this step)
            if (!decryptor.verifyPassword(Decryptor.DEFAULT_PASSWORD)) {
                System.out.println("Unable to process: document is encrypted with a non-default password.");
                return;
            }

            // Open the decrypted package
            try (InputStream dataStream = decryptor.getDataStream(fs);
                 OPCPackage opc = OPCPackage.open(dataStream)) {
                Workbook workbook = new XSSFWorkbook(opc);
                // You can now work with the workbook (if needed)
                System.out.println("Workbook has " + workbook.getNumberOfSheets() + " sheets.");
            }

        } catch (IOException | org.apache.poi.EncryptedDocumentException e) {
            System.out.println("Error processing the file: " + e.getMessage());
        }
    }
}
