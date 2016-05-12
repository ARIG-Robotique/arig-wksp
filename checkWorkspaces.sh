#!/bin/bash
# Script permettant de visualiser les changement en cours
# Author : Gregory DEPUILLE

# Inclusions des fonctions communes.
if [ -z $FUNCTIONS_INC ] ; then
	. functions.sh
fi

####################
# CORPS DU SCRIPTS #
####################

logInfo "Visualisation des changements"
gws

logInfo "Scan du worksapces"
for rootCtx in * ; do
	if [ -d $rootCtx ] && [ -f $rootCtx/.projects.gws ] ; then
		cd $rootCtx

		ALREADY_CLONED=`ls | wc -l`
		if [ "$ALREADY_CLONED" -ne "0" ] ; then
			echo ''
			logInfo "Contenu racine : $PWD"
		  gws status
		fi

		cd ..
	fi
done
