#!/bin/bash

p=`pwd`;
wdir='/home/dany1980/Dropbox/dockers/desky/deskydoo/';
wdirfe='/home/dany1980/Dropbox/dockers/desky/deskydoo/fe/js';
ugldir='/home/dany1980/Dropbox/dockers/node_modules/uglify-js/bin';

show_help () {
	echo "###########################################################################################";
	echo "### *** deskycmd ***";
	echo "### Upload deskydoo on remote google server and sync minified js, css amd img on github";
	echo "### This script uses './scripts/*sh' modules";
	echo "### ";
	echo "### GPL Licence";
	echo "### by Daniele Rugginenti 2022";
	echo "##########################################################################################";
	echo "";
	echo -e "\t** GitHub prepare and push Assets on deskyPub";
	echo -e "\t-gj --git-js       		\t Prepare all javascripts and put *min in deskypub git folder";
	echo -e "\t-gc --git-css      		\t Prepare all css and put them in deskypub git folder";
	echo -e "\t-gi --git-img      		\t Put all images in deskypub git folder";
	echo -e "\t-ga --git-prepare   		\t Execute all 3 above, prepare all assets for git";
	echo -e "\t--git-sync			\t Prepare and push on git. You need to specify a comment.";
	echo -e "\t--git-sync-n			\t Just push on git. You need to specify a comment.";
	echo -e "\t--comment 'abc'			\t Specify a comment";
	echo "";
	echo -e "\t** Sync with GitHub (push on deskydoo)";
	echo "";
	echo -e "\t** Usage";
	echo -e "./cmd_desky.sh --git-sync --comment 'Updates separated by ; to be read by frontend'"
	
	
	echo "";
}

if [ $# -eq 0 ]; then 
	show_help
	exit
fi

case $1 in
	-h)
		show_help
		;;
	-gj|--git-js)
		/bin/bash $p/scripts/git-js-do-all.sh
		echo "...done";
		;;
	-gc|--git-css)
		/bin/bash $p/scripts/git-css-do-all.sh
		echo "...done";
		;;
	-gi|--git-img)
		/bin/bash $p/scripts/git-img-do-all.sh
		echo "...done";
		;;
	-ga|--git-prepare)
		/bin/bash $p/scripts/git-js-do-all.sh
		/bin/bash $p/scripts/git-css-do-all.sh
		/bin/bash $p/scripts/git-img-do-all.sh
		echo "...done";
		;;	
	--git-sync)
		echo "Prepare and Syncing all assets on github deskypub repo";
		if [[ ! ${*} =~ "--comment" ]]; then echo "Please set a --comment"; exit; fi
		/bin/bash $p/scripts/git-js-do-all.sh
		/bin/bash $p/scripts/git-css-do-all.sh
		/bin/bash $p/scripts/git-img-do-all.sh
		/bin/bash $p/scripts/git-sync-all.sh "${@}"		
		echo "...done";
		;;	
	--git-sync-n)
		echo "Syncing all assets on github deskypub repo";
		if [[ ! ${*} =~ "--comment" ]]; then echo "Please set a --comment"; exit; fi
		/bin/bash $p/scripts/git-sync-all.sh "${@}"		
		echo "...done";
		;;	
	-gs|--git-sync)
		echo "Syncing deskydoo on github deskydoo private repo";
		if [[ ! ${*} =~ "--comment" ]]; then echo "Please set a --comment"; exit; fi
		/bin/bash $p/scripts/git-sync.sh "${@}"		
		echo "...done";
		;;	
esac
