#=============================================================================#
# Author: Gregory DEPUILLE                                                    #
# Date:   13/05/2016                                                          #
# Description: Base config pour les projets.                                  #
#=============================================================================#
# Contrôle de la version minimale de CMake
cmake_minimum_required(VERSION 3.4)

# Définition de la tool chain de build
set(CMAKE_TOOLCHAIN_FILE ./arduino-cmake/cmake/ArduinoToolchain.cmake)

# Compilateur flags
#set(ARDUINO_C_FLAGS      "-ffunction-sections -fdata-sections")
#set(ARDUINO_CXX_FLAGS    "${ARDUINO_C_FLAGS} -fno-exceptions")
#set(ARDUINO_LINKER_FLAGS "-Wl,--gc-sections")

set(ARDUINO_CXX_FLAGS    "-std=c++11")

#====================================================================#
#  Setup Project                                                     #
#====================================================================#
project(ARIGRobot C CXX)

# Affichage des cartes supportées
print_board_list()
print_programmer_list()

# Ajout des libs Arduino
link_directories(${ARDUINO_SDK_PATH}/libraries)

# Ajout des libs Adafruit
link_directories(../external/adafruit)

# Ajout des projets
add_subdirectory(quadratic-reader)
add_subdirectory(robot-system-lib)
add_subdirectory(elfa-cpp)
add_subdirectory(nerell-cpp)
