#!/bin/bash
# Script permettant de reinstaller les hooks suite a une changement de version de Python
# Author : Gregory DEPUILLE

# Inclusions des fonctions communes.
if [ -z ${FUNCTIONS_INC} ] ; then
	. functions.sh
fi

####################
# CORPS DU SCRIPTS #
####################

logInfo "Reconfiguration des hooks de pre-commit"
reinstallHooks

for rootCtx in * ; do
	if [ -d ${rootCtx} ] && [ -f ${rootCtx}/.projects.gws ] ; then
		cd ${rootCtx}

		ALREADY_CLONED=`ls | wc -l`
		if [ "${ALREADY_CLONED}" -ne "0" ] ; then
			for repo in * ; do
				if [ -d $repo ] && [ -d $repo/.git ] ; then
					cd $repo
					reinstallHooks
					cd ..
				fi
			done;
		fi

		cd ..
	fi
done
