#!/usr/bin/env bash

ROOT_DIR=$(pwd)
DOWNLOAD_DIR=/opt

ARDUINO_SDK_VERSION=1.8.8
ARDUINO_FILENAME=arduino-${ARDUINO_SDK_VERSION}-linux64
ARDUINO_FULL_FILENAME=${ARDUINO_FILENAME}.tar.xz
ARDUINO_DOWNLOAD_URL=https://downloads.arduino.cc/${ARDUINO_FULL_FILENAME}

echo "-- Download external dependencies"
cd ${DOWNLOAD_DIR}
if [[ ! -f "${ARDUINO_FULL_FILENAME}" ]] ; then
  echo "---- Download Arduino SDK $ARDUINO_SDK_VERSION ..."
  curl -L ${ARDUINO_DOWNLOAD_URL} -o ${ARDUINO_FULL_FILENAME}
  tar xvJf ${ARDUINO_FULL_FILENAME}
else
  echo "---- Déjà téléchargé"
fi
