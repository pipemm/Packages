#!/usr/bin/bash

if [[ -z "${URL_PACKAGE}" ]]
then
  exit 1
fi

echo "${URL_PACKAGE##*/}"

