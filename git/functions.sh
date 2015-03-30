#!/bin/bash
# Script contenant l'ensemble des fonctions communes a tous les autres scripts.
#
# Author : Gregory DEPUILLE

# Variable pour detecté l'inclusion
FUNCTIONS_INC=1
export FUNCTION_INC

####################
# Couleur en Shell #
####################

RESTORE='\033[0m'
export RESTORE

RED='\033[00;31m'
GREEN='\033[00;32m'
YELLOW='\033[00;33m'
BLUE='\033[00;34m'
PURPLE='\033[00;35m'
CYAN='\033[00;36m'
LIGHTGRAY='\033[00;37m'
export RED
export GREEN
export YELLOW
export BLUE
export PURPLE
export CYAN
export LIGHTGRAY

LRED='\033[01;31m'
LGREEN='\033[01;32m'
LYELLOW='\033[01;33m'
LBLUE='\033[01;34m'
LPURPLE='\033[01;35m'
LCYAN='\033[01;36m'
WHITE='\033[01;37m'
export LRED
export LGREEN
export LYELLOW
export LBLUE
export LPURPLE
export LCYAN
export WHITE

####################
# Fonctions de Log #
####################

# Fonction de log info
function logInfo {
	DATE=`date +"%d-%m-%y %T"`
	echo -e " [ ${LGREEN}INFO${RESTORE} : $DATE ] $1"
}
export -f logInfo

# Fonction de log warning
function logWarn {
	DATE=`date +"%d-%m-%y %T"`
	echo -e " [ ${LYELLOW}WARN${RESTORE} : $DATE ] $1"
}
export -f logWarn

# Fonctions de log erreur
function logError {
	DATE=`date +"%d-%m-%y %T"`
	echo -e " [ ${LRED}ERROR${RESTORE} : $DATE ] $1"
}
export -f logError

# Affiche une chaine et termine le script
function logErrorAndExit {
    logError "$1"
    exit $2
}
export -f logErrorAndExit

# Affiche une chaine et termine le script avec 0
function logInfoAndExit {
    logInfo "$1"
    exit 0
}
export -f logInfoAndExit

# Function d'execution de commande, avec sortie si erreur
function executeCmd {
	eval $1
	RESULT=$?
	[ $RESULT -ne 0 ] && logErrorAndExit "Erreur d'execution de la commande $1 => Retour : $RESULT" $RESULT
}
export -f executeCmd

################################
# Fonction de manipulation GIT #
################################

# Définition de la fonction permettant de faire un fetch du repo GIT
function fetchGit {
	GIT_REPO=${PWD##*/}
		
	logInfo "Projet Git ${LRED}$GIT_REPO${RESTORE}"

	git fetch -p 
	
	# Nettoyage dans le repo local des branches eventuellement supprimer sur le distant.
	# NB : Commande d'origine de Didier Coignet tous droits réservé.
	for b in `git branch -vv | egrep "\[origin/.*: (gone|disparue)\]" | cut -d ' ' -f3` ; do
		logInfo "Suppression de la branche local $b"
		git branch -D $b
	done
}
export -f fetchGit

# Git configuration
# Placer ici les directives de configuration des clients Git.

# Configuration global de Git
function gitGlobalConfig {
	# Ne pas garder les fichiers *.orig une fois les merges et compagnie effectué.
	git config --global mergetool.keepBackup false
	git config --global rerere.enabled true
	
	logInfo "Config global GIT"
}
export -f gitGlobalConfig

# Application de la config Git Global
gitGlobalConfig
