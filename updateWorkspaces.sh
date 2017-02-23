#!/bin/bash
# Script permettant de mettre a jour avec un prune de tous les déja récupéré.
# Author : Gregory DEPUILLE

# Inclusions des fonctions communes.
if [ -z $FUNCTIONS_INC ] ; then
	. functions.sh
fi

####################
# CORPS DU SCRIPTS #
####################

if [ -d dockers/influxdata ] ; then
	logInfo "Renomage du repo dockers/influxdata -> dockers/robot-storage"
	cd dockers/
	mv -v influxdata robot-storage
	cd robot-storage
	git remote -v
	git remote set-url origin git@github.com:ARIG-Robotique/docker-robot-storage.git
	logInfo "Nouvelle config GIT"
	git remote -v
	cd ../..
fi

logInfo "Mise a jour du workspace"
gws update
fetchGit
gws ff

logInfo "Scan du worksapce a synchroniser"
for rootCtx in * ; do
	if [ -d $rootCtx ] && [ -f $rootCtx/.projects.gws ] ; then
		logInfo "Check syncho $rootCtx"
		cd $rootCtx

		ALREADY_CLONED=`ls | wc -l`
		if [ "$ALREADY_CLONED" -ne "0" ] ; then
		  logInfo "Contenu a synchroniser détecté $PWD"
		  gws update

		  for repo in * ; do
				if [ ! -d $repo ] ; then
					continue
				fi

		    # Contrôle que le repo n'as pas été déplacer
		    grep $repo .projects.gws > /dev/null
		    if [ "$?" -ne "0" ] ; then
  		    echo -e "${LRED}$repo${RESTORE}: ${LRED} /!\\/!\\/!\\ Removed from GWS management /!\\/!\\/!\\ ${RESTORE}"
		      rm -Rf $repo
        fi

		    if [ -d $repo/.git ] ; then
          cd $repo
    			fetchGit
    			cd ..
		    fi
		  done;

		  gws ff

 		  logInfo "Configuration de MU Repo"
		  mu unregister --all
		  mu register --current

		fi

		cd ..
	fi
done
