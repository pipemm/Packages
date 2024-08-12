#!/usr/bin/bash

FontForgeApp=$(
  ls App/FontForge-*.AppImage |
  head --lines=1
)

${FontForgeApp} --version 

ls --recursive Font/


