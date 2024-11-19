#!/usr/bin/bash

FOLDER_DL='Download/'

FOLDER_INS='Installation/'
mkdir --parent "${FOLDER_INS%/}/"

ls ${FOLDER_DL%/}/*.*

