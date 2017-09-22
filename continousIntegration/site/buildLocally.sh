#!/bin/bash

buildNumber=$1

imagesName="mysite_site"

if [ -z "${buildNumber}" ]
then
    buildNumber="latest"
fi

############Make enter the root folder of all script
folderOfCurrentScript="$(dirname "${BASH_SOURCE}")"
cd ${folderOfCurrentScript}

docker rmi ${imagesName}:${buildNumber}
bash build.sh ${imagesName} ${buildNumber}