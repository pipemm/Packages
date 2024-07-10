import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.poifs.filesystem.OfficeXmlFileException;
import org.apache.poi.poifs.crypt.EncryptionInfo;
import org.apache.poi.poifs.crypt.Decryptor;
import org.apache.poi.poifs.crypt.EncryptionMode;
import org.apache.poi.poifs.crypt.HashAlgorithm;


import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

//import java.io.File;
import java.io.InputStream;
import java.io.OutputStream;

public class DecryptExcel {
    public static void main(String[] args) {
        if (args.length != 3) {
            System.err.println("Usage: java DecryptExcel <inputFile> <outputFile> <password>");
            System.exit(1);
        }

        String inputFile  = args[0];
        String outputFile = args[1];
        String password   = args[2];

        try (
            // [The try-with-resources Statement](https://docs.oracle.com/javase/tutorial/essential/exceptions/tryResourceClose.html)
            POIFSFileSystem filesystem = new POIFSFileSystem(new FileInputStream(inputFile));
            OutputStream savingStream  = new FileOutputStream(outputFile)
        ) {
            EncryptionInfo info = new EncryptionInfo(filesystem);
            Decryptor decryptor = Decryptor.getInstance(info);
            if (!decryptor.verifyPassword(password)) {
                throw new RuntimeException("Unable to process: document is encrypted");
            }
            InputStream dataStream = decryptor.getDataStream(filesystem);

            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = dataStream.read(buffer)) != -1) {
                savingStream.write(buffer, 0, bytesRead);
            }

            System.out.println("Decryption successful. Output saved to " + outputFile);
        } catch (Exception e) {
            e.printStackTrace();
        } 
    }
}
