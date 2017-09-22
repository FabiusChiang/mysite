#!/bin/bash

BUILD_NUMBER=$1
componentName=$2

############Make enter the root folder of all script
folderOfCurrentScript="$(dirname "${BASH_SOURCE}")"
cd ${folderOfCurrentScript}
folderOfCurrentScript=`pwd`

current_build_number=${BUILD_NUMBER} \
envsubst < getCurrentBuildNumber.template > getCurrentBuildNumber.sh

componentName=${componentName} \
envsubst < getDeployComponentName.template > getDeployComponentName.sh

s3RootUrl=`bash getS3RootUrlForPackages.sh`

function packageAndPush {
    cmpName=$1
	cd ..
	zip -r ${cmpName}.zip * > /dev/null
	
	aws s3 cp ${cmpName}.zip ${s3RootUrl}${BUILD_NUMBER}/${cmpName}.zip
	rm ${cmpName}.zip
	cd ${folderOfCurrentScript}
}  

packageAndPush ${componentName}

rm getCurrentBuildNumber.sh
rm getDeployComponentName.sh