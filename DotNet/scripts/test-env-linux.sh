#!/usr/bin/bash

echo "PATH=${PATH}"

which -a dotnet
dotnet --version
dotnet --list-runtimes
dotnet --list-sdks
dotnet --info
##dotnet --help
