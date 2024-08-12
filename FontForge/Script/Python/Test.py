#!/usr/bin/env fontforge

from sys       import argv
from fontforge import open

def main():
    if len(argv)<=1:
        return
    fileFont = argv[1]
    font = open(fileFont)
    # https://github.com/fontforge/fontforge/blob/master/fontforge/psfont.h
    # https://github.com/fontforge/fontforge/blob/master/doc/sphinx/scripting/python/fontforge.rst
    print("PostScript Font Family Name : ", font.familyname)
    print("PostScript Font Name        : ", font.fontname)
    print("PostScript Font Full Name   : ", font.fullname)
    print("Mac Fond Name               : ", font.fondname)
    print("PostScript Font Weight      : ", font.weight)




if __name__ == '__main__':
    main()
