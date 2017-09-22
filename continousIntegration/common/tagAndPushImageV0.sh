#!/bin/bash

appName=$1
BUILD_NUMBER=$2
componentName=$3

############Make enter the root folder of all script
folderOfCurrentScript="$(dirname "${BASH_SOURCE}")"
cd ${folderOfCurrentScript}

version=`bash getVersion.sh`
originalImageName=${appName}_${componentName}/${version}:${BUILD_NUMBER}
toSaveLocalImgName=${appName}_${componentName}/${version}.${BUILD_NUMBER}

docker tag ${originalImageName} ${toSaveLocalImgName}
docker save -o ${componentName}-${BUILD_NUMBER}.img ${toSaveLocalImgName}
s3RootUrl=`bash getS3RootUrlForPackages.sh`
aws s3 cp ${componentName}-${BUILD_NUMBER}.img ${s3RootUrl}${BUILD_NUMBER}/${componentName}-${BUILD_NUMBER}.img

docker rmi ${toSaveLocalImgName}
docker rmi ${originalImageName}

rm ${componentName}-${BUILD_NUMBER}.img