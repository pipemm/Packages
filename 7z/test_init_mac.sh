#!/bin/bash

echo "${SHELL}"

which -a man

man man | col -b

which -a col

man col | col -b

which -a which

man which | col -b

which -a readlink

man readlink | col -b

which -a bash

which -a echo

man echo | col -b

which -a curl

curl --version

curl --help

which -a head

man head | col -b

which -a sed

man sed | col -b

which -a mkdir

man mkdir | col -b

which 7z

7z --help

echo "${PATH}"

which -a pwd

man pwd | col -b

echo "${PWD}"
pwd
