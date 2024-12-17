package demo;

import java.nio.file.Paths; 
import java.nio.file.Path; 
import java.io.File;

public class GeneralReader {

    private String filePath;
    private File   file;
    
    public GeneralReader(String p) {  
        filePath  = p;
        Path path = Paths.get(filePath);
        file      = path.toFile();
        System.out.println(path.getNameCount());
    }  

    public String getContent() {
        return "";
    }

}
