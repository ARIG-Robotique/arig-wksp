#!/bin/bash
# Script permettant de mettre a jour avec un prune de tous les déja récupéré.
# Author : Gregory DEPUILLE

# Inclusions des fonctions communes.
if [ -z ${FUNCTIONS_INC} ] ; then
	. functions.sh
fi

####################
# CORPS DU SCRIPTS #
####################

# Fix d'un bug concernant la gestion du cache GWS sur MacOS X
if [ "$(uname)" == "Darwin" ] ; then
	logWarn "BUGFIX ! Suppression du cache de GWS sur $(uname)"
	find . -type f -name '.cache.gws' -exec rm -vf '{}' \;
fi

logInfo "Mise a jour du workspace"
gws update
fetchGit
gws ff --only-changes
rm -f .mu_repo
installHooks

# Liste des périmètres obsolètes
for r in aws proto saisie gendoc-templates v5 retd dev-tools ; do
	if [ -d "${r}" ] ; then
  		logWarn "${LRED}/!\\/!\\/!\\ Removed perimeter ${r} /!\\/!\\/!\\ ${RESTORE}"
  		rm -Rf $r
	fi
done

# Renommage inopiné
if [ -d amiante-voirie/voirie-parent ] ; then
	logWarn "Renommage de voirie-parent -> amiante-voirie-parent"
	mv amiante-voirie/voirie-parent amiante-voirie/amiante-voirie-parent
fi
if [ -d declaration-chantier/declaration-chantier-parent ] ; then
	logwarn "Renommage de declaration-chantier-parent -> pradictio-parent"
	mv declaration-chantier/declaration-chantier-parent declaration-chantier/pradictio-parent
fi
if [ -d declaration-chantier/declaration-chantier-multiplexeur ] ; then
  logwarn "Renommage de declaration-chantier-parent -> pradictio-parent"
  mv declaration-chantier/declaration-chantier-multiplexeur declaration-chantier/pradictio-multiplexeur
fi
if [ -d declaration-chantier/messaging-declaration-chantier-schemas ] ; then
  logwarn "Renommage de messaging-declaration-chantier-schemas -> messaging-pradictio-schemas"
  mv declaration-chantier/messaging-declaration-chantier-schemas declaration-chantier/messaging-pradictio-schemas
fi
if [ -d declaration-chantier ] ; then
	logwarn "Renommage de declaration-chantier -> pradictio"
	mv declaration-chantier pradictio
fi

logInfo "Scan du worksapce a synchroniser"
for rootCtx in * ; do
  logInfo "Check synchro $rootCtx"
	if [ -d $rootCtx ] && [ -f $rootCtx/.projects.gws ] ; then
		cd $rootCtx

		ALREADY_CLONED=`ls | wc -l`
		if [ "$ALREADY_CLONED" -ne "0" ] ; then
		  logInfo "Contenu a synchroniser détecté $PWD"
		  gws update --only-changes

		  for repo in * ; do
				if [ ! -d $repo ] ; then
					continue
				fi

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
					installHooks
					cd ..
		    fi
		  done;
		fi

		cd ..
	else
	  logWarn "$rootCtx n'est pas a synchroniser"
	fi
done

echo "$(date '+%d-%m-%Y %H:%M:%S')" > .lastUpdated
