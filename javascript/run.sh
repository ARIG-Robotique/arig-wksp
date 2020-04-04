#!/bin/bash

CURRENT_DIR=$(pwd)
START=0
PIDS=()

start() {
	if [ ${START} -eq 1 ] ; then
		echo "Already started !"
		echo ""
		return
	fi

	for p in $(ls -d */) ; do
		cd ${p}
		yarn start &
		PIDS+=($!)
		cd ..
	done
	START=1
}

quit() {
	echo "Suppression des PIDs"
	for pid in ${PIDS[@]} ; do
		echo "Remove : ${pid}"
		kill -9 ${pid}
	done
}

mainmenu() {
	echo "Press 's' to start"
	echo "Press 'q' to quit"
	read -n 1 -p "Key : " keyPressed
	echo ""
	if [ "$keyPressed" = "q" ]; then
      quit
  elif [ "$keyPressed" = "s" ]; then
      start
			mainmenu
  else
      echo "You have entered an invallid selection!"
      echo "Please try again!"
      echo ""
      mainmenu
  fi
}

mainmenu
