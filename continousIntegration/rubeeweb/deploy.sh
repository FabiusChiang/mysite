#!/bin/bash

appEnv=$1
currentVersion=$2

############Make enter the root folder of all script
folderOfCurrentScript="$(dirname "${BASH_SOURCE}")"
cd ${folderOfCurrentScript}

source ../../../credentials.sh

appName="mysite"
if [ -z "${currentVersion}" ]; then
    currentVersion=`bash ../common/getVersion.sh`
fi
baseImagesurl="fabius/"${appName}":"

#################################################################
##Web app of Rubee
rubeeWebContainerName=${appName}_rubeeweb_${appEnv}
docker stop ${rubeeWebContainerName}
docker rm ${rubeeWebContainerName}
port=`bash ../azureCommon/allocatePort.sh rubeeweb ${appEnv}`
webImageName=${baseImagesurl}rubeeweb_${currentVersion}
docker run -p ${port}:3000 --name ${rubeeWebContainerName} -e appEnv=${appEnv} -d ${webImageName}
