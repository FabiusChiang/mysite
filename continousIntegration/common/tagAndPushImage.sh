#!/bin/bash

appName=$1
version=$2
componentName=$3

############Make enter the root folder of all script
folderOfCurrentScript="$(dirname "${BASH_SOURCE}")"
cd ${folderOfCurrentScript}



localVersion=`bash getVersion.sh`
awsAccountId=`bash getAccountIdByDeployTarget.sh dev`
buildEcrRegion="us-west-2"

originalImageName=${appName}_${componentName}/${localVersion}:${version}
targetImageName=`bash getImageAndTag.sh ${appName} ${componentName} ${version}`
buildEcrImageUrl=${awsAccountId}.dkr.ecr.${buildEcrRegion}.amazonaws.com/${targetImageName}

docker tag ${originalImageName} ${buildEcrImageUrl}

loginCMD=`aws ecr get-login --region ${buildEcrRegion}`
${loginCMD}

docker push ${buildEcrImageUrl}

docker rmi ${buildEcrImageUrl}
docker rmi ${originalImageName}