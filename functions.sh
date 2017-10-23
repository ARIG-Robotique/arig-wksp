#!/bin/bash
# Script contenant l'ensemble des fonctions communes a tous les autres scripts.
#
# Author : Gregory DEPUILLE

# Variable pour detecter l'inclusion
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
	echo -e " [ ${LGREEN}INFO${RESTORE} : ${DATE} ] $1"
}
export -f logInfo

# Fonction de log warning
function logWarn {
	DATE=`date +"%d-%m-%y %T"`
	echo -e " [ ${LYELLOW}WARN${RESTORE} : ${DATE} ] $1"
}
export -f logWarn

# Fonctions de log erreur
function logError {
	DATE=`date +"%d-%m-%y %T"`
	echo -e " [ ${LRED}ERROR${RESTORE} : ${DATE} ] $1"
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

################################
# Fonction de manipulation GIT #
################################

# Définition de la fonction permettant de faire un fetch du repo GIT
function fetchGit {
	GIT_REPO=${PWD##*/}

	echo -e "${LRED}${GIT_REPO}${RESTORE}: ${LGREEN}Fetch, prune remote and clean local branch when is removed on remote.${RESTORE}"
	git fetch -p

	# Nettoyage dans le repo local des branches eventuellement supprimer sur le distant.
	for b in `git branch -vv | egrep "\[origin/.*: (gone|disparue)\]" | cut -d ' ' -f3` ; do
		logInfo "Suppression de la branche local $b"
		git branch -D $b
	done
}
export -f fetchGit

# Configuration des hooks
function configHooks {
	GIT_REPO=${PWD##*/}

	if [ -f ".pre-commit-config.yaml" ] ; then
		echo -e "${LRED}${GIT_REPO}${RESTORE}: ${LBLUE}Configuration des hooks${RESTORE}"

		for x in pre-commit pre-push commit-msg ; do
			pre-commit install -t ${x} > /dev/null
		done
	fi
}
export -f configHooks

# Configuration des hooks
function addToMu {
	GIT_REPO=$1
	echo -e "${LRED}${GIT_REPO}${RESTORE}: ${LCYAN}Ajout dans mu_repo${RESTORE}"

	echo "repo=${GIT_REPO}" >> .mu_repo
}
export -f addToMu

# Function d'execution de commande, avec sortie si erreur
function executeCmd {
	eval $1
	RESULT=$?
	[ $RESULT -ne 0 ] && logErrorAndExit "Erreur d'execution de la commande $1 => Retour : ${RESULT}" ${RESULT}
}
export -f executeCmd
