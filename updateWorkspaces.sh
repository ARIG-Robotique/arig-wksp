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

if [ -d dockers/docker-robot-storage ] ; then
	logInfo "Renomage du repo dockers/docker-robot-storage -> dockers/robot-tools"
	cd dockers/
	mv -v docker-robot-storage robot-tools
	cd robot-tools
	git remote -v
	git remote set-url origin git@github.com:ARIG-Robotique/docker-robot-tools.git
	logInfo "Nouvelle config GIT"
	git remote -v
	cd ../..
fi

logInfo "Mise a jour du workspace"
gws update
fetchGit
gws ff --only-changes
rm -f .mu_repo
configHooks

logInfo "Scan du worksapce a synchroniser"
for rootCtx in * ; do
  logInfo "Check syncho $rootCtx"
	if [ -d $rootCtx ] && [ -f $rootCtx/.projects.gws ] ; then
		cd $rootCtx

		ALREADY_CLONED=`ls | wc -l`
		if [ "$ALREADY_CLONED" -ne "0" ] ; then
		  logInfo "Contenu a synchroniser détecté $PWD"
		  gws update --only-changes

		  for repo in * ; do
		    # Contrôle que le repo n'as pas été déplacer
		    grep $repo.git .projects.gws > /dev/null
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

		  gws ff --only-changes

			if [ -f .mu_repo ] ; then
		  	rm -f .mu_repo
			fi
		  echo serial=True > .mu_repo

			for repo in * ; do
		    if [ -d $repo/.git ] ; then
					addToMu $repo

					cd $repo
					configHooks
					cd ..
		    fi
		  done;
		fi

		cd ..
	else
	  logWarn "$rootCtx n'est pas a synchroniser"
	fi
done
