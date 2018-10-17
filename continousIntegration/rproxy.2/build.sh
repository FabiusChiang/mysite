#!/bin/bash

imageName=$1
imageTag=$2

############Make enter the root folder of all script
folderOfCurrentScript="$(dirname "${BASH_SOURCE}")"
cd ${folderOfCurrentScript}

cd dockerBuild

cp -f ../../../../iisKeys/server.* ./

docker build --no-cache=true -t ${imageName}:${imageTag} -f Dockerfile .

rm server.crt server.key