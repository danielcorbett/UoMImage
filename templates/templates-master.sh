#!/bin/bash

echo -e "\nPlease select which image to create...\n"
echo -e "\n1) Juan (Code Aster & Code Saturn)"
echo -e "\n2) MAD (Mongo DB, Apache Spark and Django)"
echo -e "\n3) R"
echo -e "\n4) VNC (TigerVNC)"
echo -e ""
read -p "Selection: " selection

case "$selection" in
	1)
		BOX_NAME="juan"
		PACKAGES="base-nogui.sh anaconda.sh vagrant.sh juan.sh cleanup.sh"
		;;
	2)
		BOX_NAME="mad"
		PACKAGES="base-nogui.sh anaconda.sh vagrant.sh MAD.sh cleanup.sh"
		;;
	3)
		BOX_NAME="r"
		PACKAGES="base-nogui.sh anaconda.sh vagrant.sh cleanup.sh R.sh"
		;;
	4)
		BOX_NAME="vnc"
		PACKAGES="base-nogui.sh anaconda.sh vagrant.sh tigervnc.sh"
		;;
	esac

OUTFILE="./templates/other/template-$BOX_NAME.json"

cat ./templates/other/template-top.json > $OUTFILE
SIZE=0; for i in $PACKAGES; do SIZE=$((SIZE+1)); done
COUNT=0
for i in $PACKAGES
do
	COUNT=$((COUNT+1))
	if [ ! $COUNT -eq $SIZE ]
	then 
		echo "            \"scripts\/$i\"," >> $OUTFILE
	else
		echo "            \"scripts\/$i\"" >> $OUTFILE
	fi
done
cat ./templates/other/template-middle.json >> $OUTFILE
echo -e "          \"output\": \"centos7-$BOX_NAME.box\"" >> $OUTFILE
cat ./templates/other/template-bottom.json >> $OUTFILE

packer $OUTFILE
