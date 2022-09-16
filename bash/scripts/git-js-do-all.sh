#!/bin/bash

echo "";
echo ">> Prepare minified files and rsync them in deskyPub directory.."

p=`pwd`; 
wdirbe='/home/dany1980/Dropbox/dockers/desky/deskydoo/js/be';
wdirfe='/home/dany1980/Dropbox/dockers/desky/deskydoo/js/fe';
wdirpub='/home/dany1980/Dropbox/dockers/desky/deskyPub/js';
ugldir='/home/dany1980/Dropbox/dockers/node_modules/uglify-js/bin';


echo -e "\t- deskyPub -> be -> common_all.min.js";
cd $wdirbe;
rm -f "*_all.*js";
ls -ltr | grep -v ^d | grep -v "_all" | awk '{print $9}' | xargs cat > "common_all.js"
$ugldir/uglifyjs "common_all.js" -m -c > "common_all.min.js"
rsync -h --size-only "common_all.min.js" $wdirpub"/be/common_all.min.js";
# $ugldir/uglifyjs $wdir"common_all.js" -m -c > $wdirpub"/be/common_all.min.js"

echo -e "\t- deskyPub -> be -> qrcode.min.js";
rsync -h --mkpath --size-only $wdirbe/ext/qrcode.min.js $wdirpub/be/ext/qrcode.min.js;
echo -e "\t- deskyPub -> be -> intl_tel_input.min.js";
rsync -h --mkpath --size-only $wdirbe/ext/intlTelInput.min.js $wdirpub/be/ext/intlTelInput.min.js;


ls -ltr $wdirbe | grep ^d  | grep -v ext | awk '{print $9}' | grep -v "\." | while read line; 
	do 
		cd $wdirbe"/"$line; 
		o=`echo $line | sed 's/\///g'`; 
		echo -e "\t- deskyPub -> be -> "$o"_all.min.js";
		rm -f "*_all.*js";
		ls -I "*_all*" | xargs cat > $o"_all.js"; 
		$ugldir/uglifyjs *_all.js -m -c > $o"_all.min.js";
		rsync -h --mkpath --size-only $o"_all.min.js" $wdirpub"/be/"$o"/"$o"_all.min.js";
		# $ugldir/uglifyjs *_all.js -m -c > $wdirpub"/be/"$o"_all.min.js";
		cd $p; 
	done;

echo "";

echo -e "\t- deskyPub -> fe -> common_all.min.js";
cd $wdirfe;
rm -f "*_all.*js";
ls -ltr | grep -v ^d | grep -v "_all" | awk '{print $9}' | xargs cat > "common_all.js"
$ugldir/uglifyjs "common_all.js" -m -c > "common_all.min.js"
rsync -h --size-only "common_all.min.js" $wdirpub"/fe/common_all.min.js";
# $ugldir/uglifyjs $wdir"common_all.js" -m -c > $wdirpub"/be/common_all.min.js"
echo "";

ls -ltr $wdirfe | grep ^d  | grep -v ext | awk '{print $9}' | grep -v "\." | while read line; 
	do 
		cd $wdirfe/$line; 
		o=`echo $line | sed 's/\///g'`; 
		echo -e "\t- fe -> "$o"_all.min.js";
		rm -f "*_all.*js";
		ls -I "*_all*" | xargs cat > $o"_all.js"; 
		$ugldir/uglifyjs *_all.js -m -c > $o"_all.min.js"; 
		rsync -h --mkpath --size-only $o"_all.min.js" $wdirpub"/fe/"$o"/"$o"_all.min.js";
		cd $p; 
	done;

# cd $wdirfe;
# rm -f "*_all.*js";
# ls -ltr | grep -v ^d | grep -v "_all" | awk '{print $9}' | xargs cat > $wdirfe/"fe_all.js"
# $ugldir/uglifyjs $wdirfe/"fe_all.js" -m -c > "fe_all.min.js"

# $ugldir/uglifyjs $wdirfe/"fe_all.js" -m -c > $wdirpub"/fe/fe_all.min.js"
