#!/bin/bash

deployTarget=$1
BUILD_NUMBER=$2
appName=$3
componentName=$4

############Make enter the root folder of all script
folderOfCurrentScript="$(dirname "${BASH_SOURCE}")"
cd ${folderOfCurrentScript}

awsAccountId=`bash getAccountIdByDeployTarget.sh ${deployTarget}`
awsRegion=`bash getRegionByDeployTarget.sh ${deployTarget}`
qaAwsAccountId=`bash getAccountIdByDeployTarget.sh qa`

s3RootUrl=`bash getS3RootUrlForPackages.sh`
aws s3 cp ${s3RootUrl}${BUILD_NUMBER}/${componentName}-${BUILD_NUMBER}.img ${componentName}-${BUILD_NUMBER}.img
docker load -i ${componentName}-${BUILD_NUMBER}.img

version=`bash getVersion.sh`
toSaveLocalImgName=${appName}_${componentName}/${version}.${BUILD_NUMBER}
repositoryURI=${awsAccountId}.dkr.ecr.${awsRegion}.amazonaws.com/${appName}_${componentName}_${deployTarget}:${BUILD_NUMBER}
docker tag ${toSaveLocalImgName} ${repositoryURI}

loginToken=`aws ecr get-login`
${loginToken}

docker push ${repositoryURI}
docker rmi ${repositoryURI}
docker rmi ${toSaveLocalImgName}
rm ${componentName}-${BUILD_NUMBER}.img