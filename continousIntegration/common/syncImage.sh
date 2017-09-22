#!/bin/bash

appName=$1
deployTarget=$2
version=$3
componentName=$4

function pushImage {
    targetEnv=$1
	targetRegion=$2
    
    targetAccountId=`bash getAccountIdByDeployTarget.sh ${targetEnv}`
    targetImageUrl=${targetAccountId}.dkr.ecr.${targetRegion}.amazonaws.com/${imageName}

    docker tag ${sourceImageUrl} ${targetImageUrl}

    loginCMD=`aws ecr get-login --region ${targetRegion}`
    $loginCMD

    docker push ${targetImageUrl}
    docker rmi ${targetImageUrl}
}  

sourceAccountId=`bash getAccountIdByDeployTarget.sh dev`
if [ "dev" = "${deployTarget}" ]; then
    sourceRegion="us-west-2"
elif [ "uat" = "${deployTarget}" ]; then
    sourceRegion="us-east-1"
else
    exit 0
fi

imageName=`bash getImageAndTag.sh ${appName} ${componentName} ${version}`
echo ${imageName}
sourceImageUrl=${sourceAccountId}.dkr.ecr.${sourceRegion}.amazonaws.com/${imageName}

loginCMD=`aws ecr get-login --region ${sourceRegion}`
$loginCMD

docker pull ${sourceImageUrl}

sourceAccountId=`bash getAccountIdByDeployTarget.sh dev`
if [ "dev" = "${deployTarget}" ]; then
    pushImage "dev" "us-east-1"
elif [ "uat" = "${deployTarget}" ]; then
    pushImage "uat" "us-east-1"
    pushImage "uat" "us-west-2"
else
    exit 0
fi

docker rmi ${sourceImageUrl}