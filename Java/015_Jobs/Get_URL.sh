#!/bin/bash

if [[ "${VENDOR_JAVA}" == 'Temurin' ]]
then
  echo "Vendor ${VENDOR_JAVA}"
elif [[ "${VENDOR_JAVA}" == 'OpenJDK' ]]
then
  echo "Vendor ${VENDOR_JAVA}"
elif [[ "${VENDOR_JAVA}" == 'Oracle' ]]
then
  echo "Vendor ${VENDOR_JAVA}"
elif [[ "${VENDOR_JAVA}" == 'Corretto' ]]
then
  echo "Vendor ${VENDOR_JAVA}"
elif [[ "${VENDOR_JAVA}" == 'Microsoft' ]]
then
  echo "Vendor ${VENDOR_JAVA}"
else
  echo "Vendor not found: ${VENDOR_JAVA}"
fi