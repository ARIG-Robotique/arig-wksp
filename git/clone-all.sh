#!/bin/bash
# Script d'initialisation de tous les repo dans un workspace
#
# /!\ Script a maintenir lors de la création d'un projet
#
# Author : Gregory DEPUILLE

# Inclusions des fonctions communes.
if [ -z $FUNCTIONS_INC ] ; then
	. functions.sh
fi

###################################################
# Récupération de l'arborescence de développement #
###################################################

ROOT_DIR=`pwd`
CPP_DIR=cpp
JAVA_DIR=java
EXTERNAL_DIR=external

logInfo "Projet C++"

mkdir $CPP_DIR
cd $CPP_DIR

logInfo "Récupération de la lib arduino"
git clone git@github.com:ARIG-Robotique/arduino-core.git

logInfo "Récupération de la lib ARIG Robotique"
git clone git@github.com:ARIG-Robotique/robot-system-lib.git

logInfo "Récupération du programme de lecture codeurs ARIG"
git clone git@github.com:ARIG-Robotique/quadratic-reader.git

logInfo "Récupération du programme du robot principal"
git clone git@github.com:ARIG-Robotique/robot-main-big.git

logInfo "Récupération du programme du robot secondaire"
git clone git@github.com:ARIG-Robotique/robot-main-small.git

cd $ROOT_DIR

logInfo "Récupération des dépendances externes"

mkdir -p $EXTERNAL_DIR/adafruit
cd $EXTERNAL_DIR/adafruit

git clone git@github.com:adafruit/Adafruit_Sensor.git
git clone git@github.com:adafruit/Adafruit_10DOF.git
git clone git@github.com:adafruit/Adafruit_BMP085_Unified.git
git clone git@github.com:adafruit/Adafruit-GFX-Library.git
git clone git@github.com:adafruit/Adafruit_L3GD20.git
git clone git@github.com:adafruit/Adafruit_L3GD20_U.git
git clone git@github.com:adafruit/Adafruit_LSM303DLHC.git
git clone git@github.com:adafruit/Adafruit_SSD1306.git
git clone git@github.com:adafruit/Adafruit_TCS34725.git

cd $ROOT_DIR