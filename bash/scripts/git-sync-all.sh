#!/bin/bash
echo "Executing git sync module";
echo -e "\t- Retrieving comment";
echo "";
tA=("${@}");
for ((i=0; i < ${#tA[@]}; i++)); do
	if [ "${tA[i]}" == "--comment" ]; then
		version_comment="${tA[i+1]}"
	fi
	if [ "${tA[i]}" == "--update" ]; then
		update_type="${tA[i+1]}"
	fi
done

wdirpub='/home/dany1980/Dropbox/dockers/desky/deskyPub/';
wdirdesk='/home/dany1980/Dropbox/dockers/desky/';


#### ASSETS COMMIT AND PUSH
cd $wdirpub;

echo -e "\t- Getting version and updating it on github and on localDB";
# get version number to tag
v=`git tag -l | tail -1`;
v1=`echo $v | cut -d. -f1`
v2=`echo $v | cut -d. -f2`
v3=`echo $v | cut -d. -f3 | sed 's/^[0]*//'`

if  [[ $update_type -eq 1 ]]; then 
	# important update
	# increase v2
	v2=$(( $v2+1 ));
	v3="0001";
elif [[ $update_type -eq 2 ]]; then
	v1=$(( $v1+1 ));
	v2=0;
	v3="0001";
else 
	v3=$(( $v3+1 ));
	v3=$(printf "%04d" $v3)
fi
new_version=$v1"."$v2"."$v3;
echo -e "\t- -*version $v --> $new_version";

# generate the version file in the pub folder
echo "" >> _version.txt
echo "---" >> _version.txt
echo -e "\t- -*version $v --> $new_version" >> _version.txt
echo $version_comment >> _version.txt

# update version number on local server
curl -X POST -F 'q=update_app_version' -F 'key=USE_SOME_KEY_RECOGNIZED_BY_YOUR_BACKEND' -F "version=$new_version" http://localhost/servers/settingsAdminUpdateAppVersion.php

echo "";
echo "Version was updated on local DB only. Version will be updated on remote DB on pull. Remember to pull on server to apply changes on code"

echo "";
echo -e "*** Pushing assets on github ***";
git add -A
git commit -am "$version_comment";
git tag -a $new_version -m "$version_comment";
git push origin main $new_version
echo "done";
echo ""

echo -e "*** Pushing project on github ***";
cd $wdirdesk
git add -A
git commit -am "$version_comment";
git tag -a $new_version -m "$version_comment";
git push origin main $new_version

echo "done";

