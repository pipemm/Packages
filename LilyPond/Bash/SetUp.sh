#!/usr/bin/bash

subfolder=$(
  ls --directory Package/lilypond-*/bin/ |
  head --lines=1
)
PATH_LILYPOND="${PWD%/}/${subfolder%/}/"
PATH="${PATH}:${PATH_LILYPOND%/}"

#### [Limitation](https://github.com/actions/download-artifact?tab=readme-ov-file#limitations)
#### File permissions are not maintained during artifact upload. All directories will have 755 and all files will have 644.
  ## bin/
chmod u+x ${PATH_LILYPOND%/}/*
  ## libexec/
chmod u+x ${PATH_LILYPOND%/bin/}/libexec/*

lilypond --version
lilypond --help
if [[ -n "${GITHUB_ENV}" ]]
then
echo "PATH_LILYPOND=${PATH_LILYPOND}"
echo "PATH_LILYPOND=${PATH_LILYPOND}" >> "${GITHUB_ENV}"
echo "PATH=${PATH}"
echo "PATH=${PATH}"                   >> "${GITHUB_ENV}"
fi
