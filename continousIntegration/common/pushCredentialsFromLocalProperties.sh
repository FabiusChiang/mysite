#!/bin/bash

originalFile=$1
appName=$2
componentName=$3
appEnv=$4
purpose=$5

# file="/home/fabius/workspace/eams/evnTest/envTable.sh"

folderOfCurrentScript="$(dirname "${BASH_SOURCE}")"
cd ${folderOfCurrentScript}

if [ -z "${purpose}" ]
then
    purpose="runtime"
fi

if [ -f "${originalFile}" ]
then
  echo "${originalFile} is found. Deploying credentials..."

  file=credential.tmp
  cp ${originalFile} ${file}
  ##ensure the last line will be loaded even there was no newline in the end of file;
  echo "" | tee -a ${file}

  while IFS='=' read -r key value
  do
    if [ ! -z "${key}" ] && [ ! -z "${value}" ]; then
      bash pushCredentialToParameterStore.sh ${appName} ${componentName} ${appEnv} ${purpose} ${key} ${value}
    fi
  done < "${file}"
  rm ${file}
else
  echo "Credential property file - ${originalFile} not found... ignore pushing credentials from local properties file."
fi