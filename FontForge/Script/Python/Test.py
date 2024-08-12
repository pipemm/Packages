#!/usr/bin/env fontforge

from sys import argv
from fontforge import open

def main():
    if len(argv)<=1:
        return
    fileFont = argv[1]
    font = open(fileFont)
    # https://github.com/fontforge/fontforge/blob/master/fontforge/psfont.h
    # https://github.com/fontforge/fontforge/blob/master/doc/sphinx/scripting/python/fontforge.rst
    print("Font Name: ", font.fontname)
    print("Full Name: ", font.fullname)
    print("Family Name: ", font.familyname)


if __name__ == '__main__':
    main()
