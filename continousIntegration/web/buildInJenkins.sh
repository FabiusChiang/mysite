#!/bin/bash

BUILD_NUMBER=$1

############Make enter the root folder of all script
folderOfCurrentScript="$(dirname "${BASH_SOURCE}")"
cd ${folderOfCurrentScript}

appName=mysite
componentName=web
version=`bash ../common/getVersion.sh`

componentImageName=${appName}_${componentName}/${version}
bash build.sh ${componentImageName} ${BUILD_NUMBER}
bash ../common/tagAndPushImage.sh ${appName} ${BUILD_NUMBER} ${componentName}

##Temporarilly, we don't need to create a package for deployment scripit.
# bash ../common/createPackage.sh ${BUILD_NUMBER} ${componentName}