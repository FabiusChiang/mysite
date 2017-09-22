#!/bin/bash

appName=$1
componentName=$2
appEnv=$3
purpose=$4
key=$5
value=$6

parameterName=${appEnv}.${appName}.${componentName}.${key}
kmsKeyAliasName=${appName}-${componentName}-${appEnv}-${purpose}

kmsKeyId=`bash ../buildAWSResources/kms/getKeyIdByAliasName.sh ${kmsKeyAliasName}`

aws ssm put-parameter --name ${parameterName} --value ${value} --type SecureString --key-id ${kmsKeyId} --overwrite