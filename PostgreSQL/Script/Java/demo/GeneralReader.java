package demo;

import java.nio.file.Paths; 
import java.nio.file.Path; 
import java.nio.file.Files;
import java.io.File;
import java.io.IOException;
import java.lang.RuntimeException;

import demo.IReader;

public class GeneralReader implements IReader {

    private String filePath;
    private File   file;
    private String baseName;
    
    public GeneralReader(String p) {  
        filePath  = p;
        Path path = Paths.get(filePath);
        if( path.getNameCount() == 0 ) {
            throw new IllegalArgumentException("wrong path " + path);
        }

        file = path.toFile();
        if ( ! (file.isFile() & file.canRead()) ) {
            throw new IllegalArgumentException("cannot read " + path);
        }

        String fn = path.getFileName().toString();
        if ( fn.matches("^[^.]+[.][^.]+$") ) {
            baseName = fn.replaceFirst("[.][^.]+$", "");
        } else {
            baseName = fn;
        }

    }  
    
    public String getBaseName() {
        return baseName;
    }

    public String getContent() {
        try {
            return new String(Files.readAllBytes(file.toPath()));
        } catch (IOException e) {
            e.printStackTrace();
            throw new RuntimeException("reader error");
        }
    }

}
