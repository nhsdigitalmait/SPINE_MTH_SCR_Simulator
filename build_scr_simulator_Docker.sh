#!/bin/bash
# build docker image for SCR simulator
# usage build_scr_simulator_Docker.sh [<userid>]
# if no user id is provided it defaults to 1000 and the tag is just the version number
#
TAG=0.1

if [[ "$1" == "" ]]
then
	USER_ID=1000
else
	USER_ID=$1
	TAG+=-$USER_ID
fi

IMAGENAME=tkw_scr_simulator
PROJECT=SPINE_MTH_SCR_Simulator

echo "Building $IMAGENAME:$TAG"
read -n 1 -p "Press any key to continue..."
echo building

# the source folder must be in uninstall mode(TKW_ROOT) not inistall mode (with real paths)
cd $TKWROOT/config/$PROJECT
fixtkwroot.sh -u .
cd -

# put the git commit hash and date into a text file
echo "SCR Simulator Version: $TAG"  > version_string.txt
echo "SCR Github repository shortcode:" `git show -s --format="$PROJECT %h %cI"` >> version_string.txt

#Build the docker image
docker build --build-arg USER_ID=$USER_ID -f Dockerfile -t nhsdigitalmait/$IMAGENAME:$TAG .
echo Docker Image tagged with $TAG
