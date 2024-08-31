#!/usr/bin/bash

URL_DOWNLOAD_PAGE='https://lilypond.org/download.html'
curl "${URL_DOWNLOAD_PAGE}" |
  sed --silent 's!^.*"\(http[s]\?://[^"]*\)".*$!\1!p' |
  tee >(
    sed --silent '/lilypond-[0-9.]\+-linux-x86_64\.tar\.gz$/p' |
    head --lines=1 |
    while read -r url
    do
      URL_DOWNLOAD_LINUX="${url}"
      if [[ -n "${GITHUB_OUTPUT}" ]]
      then
      echo "URL_DOWNLOAD_LINUX=${URL_DOWNLOAD_LINUX}"
      echo "URL_DOWNLOAD_LINUX=${URL_DOWNLOAD_LINUX}" >> "${GITHUB_OUTPUT}"
      fi
    done
  ) >(
    sed --silent '/lilypond-[0-9.]\+-mingw-x86_64\.zip$/p' |
    head --lines=1 |
    while read -r url
    do
      URL_DOWNLOAD_WINDOWS="${url}"
      if [[ -n "${GITHUB_OUTPUT}" ]]
      then
      echo "URL_DOWNLOAD_WINDOWS=${URL_DOWNLOAD_WINDOWS}"
      echo "URL_DOWNLOAD_WINDOWS=${URL_DOWNLOAD_WINDOWS}" >> "${GITHUB_OUTPUT}"
      fi
    done
  ) >(
    sed --silent '/lilypond-[0-9.]\+-darwin-x86_64\.tar\.gz$/p' |
    head --lines=1 |
    while read -r url
    do
      URL_DOWNLOAD_MAC="${url}"
      if [[ -n "${GITHUB_OUTPUT}" ]]
      then
      echo "URL_DOWNLOAD_MAC=${URL_DOWNLOAD_MAC}"
      echo "URL_DOWNLOAD_MAC=${URL_DOWNLOAD_MAC}" >> "${GITHUB_OUTPUT}"
      fi
    done
  )

