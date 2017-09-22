#!/bin/bash

appName=$1
componentName=$2
version=$3
deployTarget=$4
awsRegion=$5
ecrRegion=$6
needPublicELB=$7

folderOfCurrentScript="$(dirname "${BASH_SOURCE}")"
cd ${folderOfCurrentScript}

if [ -z "${needPublicELB}" ]; then
    needPublicELB="false"
fi

bash deployCredentials.sh ${appName} ${componentName} ${deployTarget} ${awsRegion}

bash ../buildAWSResources/cloudFormation/components-Specific/createComponent.sh ${appName} ${deployTarget} ${componentName} ${awsRegion} ${version} ${ecrRegion} ${needPublicELB}
bash ../buildAWSResources/cloudFormation/envComponent-Specific/createDNS.sh ${appName} ${deployTarget} ${componentName} ${awsRegion}