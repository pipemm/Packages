package demo;

import demo.Handler;

public class Tester {

    public static void main(String[] args) {
        
        if ( args.length < 1 ) {
            System.err.println("needs a script.");
            return;
        }
        String pathScript = args[0];
        
        String pathOut = null;
        if ( args.length >= 2 ) {
            pathOut = args[1];
        }
        Handler.handler(pathScript, pathOut);

    }

}
