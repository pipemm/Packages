#!/usr/bin/bash

FontForgeApp=$(
  ls App/FontForge-*.AppImage |
  head --lines=1
)

chmod u+x ${FontForgeApp}

${FontForgeApp} --appimage-extract-and-run --version 

ls --recursive Font/


