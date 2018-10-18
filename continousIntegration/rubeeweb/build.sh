#!/bin/bash

imageName=$1
imageTag=$2

############Make enter the root folder of all script
folderOfCurrentScript="$(dirname "${BASH_SOURCE}")"
cd ${folderOfCurrentScript}

git clone -b develop --single-branch https://github.com/kathrine1102/mygit.git --depth 1
cp -r ./mygit/program ./dockerBuild/app
cp ./mygit/package.json ./dockerBuild/app

cd dockerBuild

docker build --no-cache=true -t ${imageName}:${imageTag} -f Dockerfile .