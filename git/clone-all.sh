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
JS_DIR=js
ELEC_DIR=electronique
EXTERNAL_DIR=external

###################################################

logInfo "Projet C++"

cd $ROOT_DIR
mkdir $CPP_DIR
cd $CPP_DIR

logInfo "Récupération de la lib arduino"
git clone git@github.com:ARIG-Robotique/arduino-core.git

logInfo "Récupération de la lib ARIG Robotique"
git clone git@github.com:ARIG-Robotique/robot-system-lib.git

logInfo "Récupération du programme de lecture codeurs ARIG"
git clone git@github.com:ARIG-Robotique/quadratic-reader.git

logInfo "Récupération du programme du robot principal (Nerell)"
git clone git@github.com:ARIG-Robotique/nerell-cpp.git

logInfo "Récupération du programme du robot secondaire (Elfa)"
git clone git@github.com:ARIG-Robotique/elfa-cpp.git

###################################################

logInfo "Projet Java"

cd $ROOT_DIR
mkdir $JAVA_DIR
cd $JAVA_DIR

logInfo "Récupération de la lib ARIG Robotique"
git clone git@github.com:ARIG-Robotique/robot-system-lib-parent.git

logInfo "Récupération du programme du robot principal (Nerell)"
git clone git@github.com:ARIG-Robotique/nerell-java.git

logInfo "Récupération du programme du robot secondaire (Elfa)"
git clone git@github.com:ARIG-Robotique/elfa-java.git

###################################################

logInfo "Projet Javascript"

cd $ROOT_DIR
mkdir $JS_DIR
cd $JS_DIR

logInfo "Récupération du monitoring Nerell"
git clone git@github.com:ARIG-Robotique/nerell-monitor.git

###################################################

logInfo "Projet Electronique"

cd $ROOT_DIR
mkdir $ELEC_DIR
cd $ELEC_DIR

logInfo "Récupération des parts Fritzing"
git clone git@github.com:ARIG-Robotique/fritzing-parts.git

###################################################

logInfo "Récupération des dépendances externes"

cd $ROOT_DIR
mkdir -p $EXTERNAL_DIR/adafruit
cd $EXTERNAL_DIR/adafruit

logInfo "Dépendances Adafruit"

logInfo "Dépendances pour l'écran LCD"
git clone git@github.com:adafruit/Adafruit-GFX-Library.git
git clone git@github.com:adafruit/Adafruit_SSD1306.git

logInfo "Dépendances pour le Gyroscope (10 DOF : BMP085, L3GD20, LSM303)"
git clone git@github.com:adafruit/Adafruit_Sensor.git
git clone git@github.com:adafruit/Adafruit_BMP085_Unified.git
git clone git@github.com:adafruit/Adafruit_L3GD20_U.git
git clone git@github.com:adafruit/Adafruit_LSM303DLHC.git
git clone git@github.com:adafruit/Adafruit_10DOF.git

logInfo "Dépendances pour le capteur RGB"
git clone git@github.com:adafruit/Adafruit_TCS34725.git

cd $ROOT_DIR
mkdir -p $EXTERNAL_DIR/ninjablocks
cd $EXTERNAL_DIR/ninjablocks

logInfo "Dépendances Ninjablocks"

logInfo "Dépendances Arduino"
git clone git@github.com:ninjablocks/arduino.git

###################################################

cd $ROOT_DIR
