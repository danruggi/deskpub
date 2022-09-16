#!/bin/bash

echo "";
echo ">> Copy modified css in deskyPub directory.."
p=`pwd`; 
wdirbe='/home/dany1980/Dropbox/dockers/desky/deskydoo/css/be';
wdirfe='/home/dany1980/Dropbox/dockers/desky/deskydoo/css/fe';
wdirpub='/home/dany1980/Dropbox/dockers/desky/deskyPub/css';

echo -e "\t - deskyPub -> be css files"
cd $wdirbe;
cat colors.css inputs.css buttons.css header.css messages.css popup.css ul.css cards.css > common.css
rsync -a $wdirbe/*.css $wdirpub/be/

echo -e "\t - deskyPub -> fe css files"
rsync -a $wdirfe/*.css $wdirpub/fe/
