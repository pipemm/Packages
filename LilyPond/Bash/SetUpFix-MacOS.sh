#!/bin/bash

subfolder=$(
  ls -d Package/lilypond-*/bin/ |
  head -n 1
)
PATH_LILYPOND="${PWD%/}/${subfolder%/}/"
PATH="${PATH}:${PATH_LILYPOND%/}"

## bin/
chmod u+x ${PATH_LILYPOND%/}/*
## libexec/
chmod u+x ${PATH_LILYPOND%/bin/}/libexec/*

## The program inspects Scheme source code files (.scm) and their corresponding compiled files (.go). 
## If a source code file has a more recent timestamp than its compiled counterpart, a warning message is shown. 
## This issue appears to be linked to the GUILE_AUTO_COMPILE=1 setting.
## The program might then attempt to recompile the source code, which is likely to result in a fatal error, possibly because the current environment is not configured for compiling.
find Package/lilypond-*/lib/*/*/ccache/*/ -name '*.go' |
  while read -r gofile
  do
    touch "${gofile}"
  done

lilypond --version
lilypond --help

if [[ -n "${GITHUB_ENV}" ]]
then
  echo "PATH_LILYPOND=${PATH_LILYPOND}"
  echo "PATH_LILYPOND=${PATH_LILYPOND}" >> "${GITHUB_ENV}"
  echo "PATH=${PATH}"
  echo "PATH=${PATH}"                   >> "${GITHUB_ENV}"
fi
