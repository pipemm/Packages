import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.poifs.filesystem.OfficeXmlFileException;
import org.apache.poi.poifs.crypt.EncryptionInfo;
import org.apache.poi.poifs.crypt.Decryptor;
import org.apache.poi.poifs.crypt.EncryptionMode;
import org.apache.poi.poifs.crypt.HashAlgorithm;


import java.io.FileInputStream;
import java.io.IOException;

// [Encryption](https://poi.apache.org/encryption.html)
public class EncryptionInformation {

    public static void main(String[] args) {
        if (args.length != 1) {
            System.out.println("Usage: java EncryptionInformation <filename>");
            return;
        }

        String filename = args[0];

        try (
            // [The try-with-resources Statement](https://docs.oracle.com/javase/tutorial/essential/exceptions/tryResourceClose.html)
            POIFSFileSystem fs = new POIFSFileSystem(new FileInputStream(filename))
        ) {
            EncryptionInfo info = new EncryptionInfo(fs);
            //Decryptor decryptor = Decryptor.getInstance(info);

            // Print encryption details
            EncryptionMode encryptionMode = info.getEncryptionMode();
            HashAlgorithm  hashAlgorithm  = info.getVerifier().getHashAlgorithm();
            int            keySize        = info.getHeader().getKeySize();
            
            System.out.println("Encryption Mode : " + encryptionMode);
            System.out.println("Hash Algorithm  : " + hashAlgorithm);
            System.out.println("Key Size        : " + keySize + " bits");

        } catch (IOException e) {
            System.out.println("Error reading the file: " + e.getMessage());
        } catch (OfficeXmlFileException e) {
            System.out.println("The file may not be encrypted because it is not stored in an OLE format. ");
        }
    }
}
