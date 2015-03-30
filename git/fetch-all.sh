#!/bin/bash
# Script permettant de mettre a jour avec un prune de tous les repos.
# Author : Gregory DEPUILLE

# Inclusions des fonctions communes.
if [ -z $FUNCTIONS_INC ] ; then
	. functions.sh
fi

####################
# CORPS DU SCRIPTS #
####################

for tmp in * ; do
	if [ -d $tmp ] && [ -d "$tmp/.git" ] ; then
		cd $tmp
		fetchGit
	fi
done