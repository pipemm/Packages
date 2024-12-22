package demo;

import java.io.Writer;
import java.io.IOException;
import java.util.Objects;

public class BufferedWriter extends Writer {
    // https://github.com/corretto/corretto-21/blob/develop/src/java.base/share/classes/java/io/BufferedWriter.java
    // https://github.com/adoptium/jdk21u/blob/master/src/java.base/share/classes/java/io/BufferedWriter.java
    // https://github.com/microsoft/openjdk-jdk21u/blob/main/src/java.base/share/classes/java/io/BufferedWriter.java

    private static final int BUFFER_SIZE_MINIMUM =      5 *1024*1024; // 5 MiB
    private static final int BUFFER_SIZE_MAXIMUM = 5 *1024*1024*1024; // 5 GiB
    private static final int BUFFER_SIZE         = BUFFER_SIZE_MINIMUM;
    private char[]           buffer;
    private int              position;
    private Writer           out; // The underlying writer
    
    public BufferedWriter(Writer out) {
        if (out == null) {
            throw new NullPointerException();
        }
        this.out      = out;
        this.buffer   = new char[BUFFER_SIZE];
        this.position = 0;
    }

    private int min(int a, int b) {
        if (a < b) {
            return a;
        }
        return b;
    }

    private void ensureOpen() throws IOException {
        if (out == null) {
            throw new IOException("Stream closed");
        }
    }

    public void write(char[] cbuf, int off, int len) throws IOException {
        ensureOpen();
        if (cbuf == null) {
            throw new NullPointerException();
        }
        Objects.checkFromIndexSize(off, len, cbuf.length);

        int coff = off;
        int clen = len;
        while (clen > 0) {
            int spaceLeft = buffer.length - position;
            int lenToCopy = min(clen, spaceLeft);
            System.arraycopy(cbuf, coff, buffer, position, lenToCopy);
            position += lenToCopy;
            coff     += lenToCopy;
            clen     -= lenToCopy;

            if (position == buffer.length) {
                flushBuffer();
            }
        }
    }

    public void flush() throws IOException {
        ensureOpen();
        if (position == buffer.length) {
            flushBuffer();
        }
    }

    private void flushBuffer() throws IOException {
        if (position > 0) {
            out.write(buffer, 0, position);
            position = 0;
        }
    }

    public void close() throws IOException {
        if (out == null) {
            return;
        }
        try (Writer w = out) {
            flushBuffer();
        } finally {
            out    = null;
            buffer = null;
        }
    }
}
