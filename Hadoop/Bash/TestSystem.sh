#!/usr/bin/bash

which -a lsb_release
lsb_release --version
lsb_release -- help

which -a uname
uname --version
uname --help

lsb_release --all
uname --all

cat /etc/os-release
