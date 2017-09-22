#!/bin/bash

deployTarget=$1
version=$2
componentName=$3
awsRegion=$4

############Make enter the root folder of all script
folderOfCurrentScript="$(dirname "${BASH_SOURCE}")"
cd ${folderOfCurrentScript}

appName=financialplan

if [ -z "${version}" ]
then
    version=`bash getCurrentBuildNumber.sh`
fi

if [ -z "${componentName}" ]
then
    componentName=`bash getDeployComponentName.sh`
fi

export PATH=$PATH:/usr/local/bin/

if [ -z "${awsRegion}" ]; then
    awsRegion=`bash getRegionByDeployTarget.sh ${deployTarget}`
    # aws configure set region ${awsRegion}
    export AWS_DEFAULT_REGION="${awsRegion}"
    echo ${awsRegion}
fi

# bash pushPackageFromS3ToRepository.sh ${deployTarget} ${version} ${appName} ${componentName}
bash syncImage.sh ${appName} ${deployTarget} ${version} ${componentName}

cd ../${componentName}/
bash launchNewVersion.sh ${appName} ${version} ${deployTarget} ${awsRegion} ${awsRegion} 
