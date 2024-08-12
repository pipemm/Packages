#!/usr/bin/env fontforge

from sys import argv
import fontforge

def main():
    print(len(argv))
    if len(argv)>1:
        print(argv[0])
        print(argv[1])

if __name__ == '__main__':
    main()
