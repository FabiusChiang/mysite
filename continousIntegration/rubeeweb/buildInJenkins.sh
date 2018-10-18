#!/bin/bash

version=$1

############Make enter the root folder of all script
folderOfCurrentScript="$(dirname "${BASH_SOURCE}")"
cd ${folderOfCurrentScript}

appName=mysite
componentName=rubeeweb

if [ -z "${version}" ]; then
    version=`bash ../common/getVersion.sh`
fi

componentImageName="fabius/"${appName}
bash build.sh ${componentImageName} ${componentName}_${version}

docker push ${componentImageName}:${componentName}_${version}