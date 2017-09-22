#!/bin/bash

appName=$1
componentName=$2
appEnv=$3

folderOfCurrentScript="$(dirname "${BASH_SOURCE}")"
cd ${folderOfCurrentScript}

currentPath=`pwd`
propertiesFile=${currentPath}"/../${componentName}/${appEnv}.credentials.properties"

bash ../common/pushCredentialsFromLocalProperties.sh ${propertiesFile} ${appName} ${componentName} ${appEnv}