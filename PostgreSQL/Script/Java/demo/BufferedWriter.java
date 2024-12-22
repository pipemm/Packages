package demo;

import java.io.IOException;
import java.io.Writer;

public class BufferedWriter extends Writer {
    private static final int BUFFER_SIZE_MINIMUM =      5 *1024*1024;
    private static final int BUFFER_SIZE_MAXIMUM = 5 *1024*1024*1024;
    private static final int BUFFER_SIZE         = BUFFER_SIZE_MINIMUM;
    private char[]           buffer;
    private int              position;
    private Writer           out; // The underlying writer
    
    public BufferedWriter(Writer out) {
        if (out == null) {
            throw new NullPointerException("output writer cannot be null");
        }
        this.out      = out;
        this.buffer   = new char[BUFFER_SIZE];
        this.position = 0;
    }

    // Implement the write method for char[] with offset and length
    @Override
    public void write(char[] cbuf, int off, int len) throws IOException {
        if (cbuf == null) {
            throw new NullPointerException("Character array cannot be null");
        }
        if (off < 0 || len < 0 || off + len > cbuf.length) {
            throw new IndexOutOfBoundsException("Invalid offset or length");
        }

        int i = off;
        // Fill the buffer and flush if necessary
        while (len > 0) {
            int spaceLeft = buffer.length - position;
            int toCopy    = Math.min(len, spaceLeft);
            System.arraycopy(cbuf, i, buffer, position, toCopy);
            position += toCopy;
            i        += toCopy;
            len      -= toCopy;

            if (position == buffer.length) {
                flushBuffer();
            }
        }
    }

    // Implement the flush method to write the content of the buffer
    @Override
    public void flush() throws IOException {
        if (position == buffer.length) {
            flushBuffer();
        }
    }

    // Helper method to flush the buffer
    private void flushBuffer() throws IOException {
        if (position > 0) {
            out.write(buffer, 0, position);
            position = 0;
        }
    }

    // Implement the close method to close the underlying writer
    @Override
    public void close() throws IOException {
        try {
            flushBuffer();
        } finally {
            out.close();
        }
    }
}
