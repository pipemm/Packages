package demo;

import java.io.IOException;

interface ReaderInterface {

    public String getBaseName();

    public String getContent() throws IOException;

}