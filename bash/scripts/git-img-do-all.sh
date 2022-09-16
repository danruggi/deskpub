#!/bin/bash

echo "";
echo ">> Copy modified images in deskyPub directory.."

p=`pwd`; 
wdirbe='/home/dany1980/Dropbox/dockers/desky/deskydoo/assets/be';
wdirfe='/home/dany1980/Dropbox/dockers/desky/deskydoo/assets/fe';
wdirpub='/home/dany1980/Dropbox/dockers/desky/deskyPub/assets';


rsync -ar $wdirbe/* $wdirpub/be/
rsync -ar $wdirfe/* $wdirpub/fe/
