#!/usr/bin/bash

FontForgeApp=$(
  ls App/FontForge-*.AppImage |
  head --lines=1
)
chmod u+x ${FontForgeApp}

${FontForgeApp} --appimage-extract-and-run --version 

folderpy='Python/'
pytest="${PWD%/}/${folderpy%/}/Test.py"

ls Font/*/*.* |
  while read -r file
  do
    echo ${file}
    ${FontForgeApp} --appimage-extract-and-run -lang=py -script "${pytest}" "${file}"
  done

