#!/usr/bin/bash

thisscript=$(readlink -f "$0")
thispath="${thisscript%/*}/"
cd "${thispath}"

## https://mvnrepository.com/artifact/software.amazon.awssdk/s3