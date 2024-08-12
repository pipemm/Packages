#!/usr/bin/bash

ls --recursive Font/

FontForgeApp=$(
  ls App/FontForge-*.AppImage |
  head --lines=1
)

${FontForgeApp}
