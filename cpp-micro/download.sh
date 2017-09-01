#!/usr/bin/env bash

ROOT_DIR=$(pwd)
DOWNLOAD_DIR=/opt

ARDUINO_SDK_VERSION=1.0.6
ARDUINO_FILENAME=arduino-${ARDUINO_SDK_VERSION}-linux64
ARDUINO_DOWNLOAD_URL=https://downloads.arduino.cc/${ARDUINO_FILENAME}.tgz

cd $DOWNLOAD_DIR
if [ ! -f "$ARDUINO_FILENAME.tgz" ] ; then
  echo "---- Download Arduino SDK $ARDUINO_SDK_VERSION ..."
  curl -L $ARDUINO_DOWNLOAD_URL -o $ARDUINO_FILENAME.tgz
  tar xvzf $ARDUINO_FILENAME.tgz
fi
