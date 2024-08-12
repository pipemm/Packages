#!/usr/bin/bash

FontForgeApp=$(
  ls App/FontForge-*.AppImage |
  head --lines=1
)

chmod a+x ${FontForgeApp}

${FontForgeApp} --version 

ls --recursive Font/


