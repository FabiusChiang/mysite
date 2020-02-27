#!/bin/bash

appName=$1
targetEnv=$2
componentName=$3
awsRegion=$4

##############################Debug#####
appName=fabiustest
targetEnv=dev
componentName="waftest"
awsRegion="us-west-2"
##############################End-Debug#####


############Make enter the root folder of all script
folderOfCurrentScript="$(dirname "${BASH_SOURCE}")"
cd ${folderOfCurrentScript}
currentPath=`pwd`

purpose="testwaf"


templateFile=${currentPath}"/waf.yaml"

#Cluster name
clusterName=${appName}_${targetEnv}

if [ ! -z "${awsRegion}" ]; then
    export AWS_DEFAULT_REGION=${awsRegion}
    echo "Use the region ${awsRegion}"
fi

##ImageUrl
if [ -z "${ecrRegion}" ]; then
    ecrRegion="us-east-1"
fi

parameterFile="${currentPath}/parameters.json"

echo '[
{"ParameterKey":"AppName","ParameterValue": "'${appName}'"},
{"ParameterKey":"TargetEnv","ParameterValue": "'${targetEnv}'"},
{"ParameterKey":"ComponentName","ParameterValue": "'${componentName}'"}
]' | tee ${parameterFile}

bash createOrUpdateStack.sh ${appName}-${purpose}-${targetEnv}-${awsRegion} \
"${templateFile}" \
false \
${parameterFile} \
${targetEnv}

rm ${parameterFile}
