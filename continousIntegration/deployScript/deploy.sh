#!/bin/bash

currentVersion=$1

############Make enter the root folder of all script
folderOfCurrentScript="$(dirname "${BASH_SOURCE}")"
cd ${folderOfCurrentScript}

##mysite_web
##mysite_node

appName="mysite"
if [ -z "${currentVersion}" ]; then
    currentVersion=`bash ../common/getVersion.sh`
fi


baseImagesurl="fabius/"${appName}":"

#1. Stop original
webContainerName=${appName}_web

docker stop ${webContainerName}
docker rm ${webContainerName}

#2. Get all new images
webImageName=${baseImagesurl}web_${currentVersion}
docker rmi webImageName
docker pull ${webImageName}

#3. Launch images per sequence
docker run -p 80:80 --name ${webContainerName} -d ${webImageName}
