#!/usr/bin/bash

echo "PATH=${PATH}"
echo "DOTNET_ROOT=${DOTNET_ROOT}"

which -a dotnet
dotnet --version
dotnet --list-runtimes
dotnet --list-sdks
dotnet --info
##dotnet --help
