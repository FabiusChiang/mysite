#!/bin/bash

appEnv=$1
currentVersion=$2

############Make enter the root folder of all script
folderOfCurrentScript="$(dirname "${BASH_SOURCE}")"
cd ${folderOfCurrentScript}

appName="mysite"
if [ -z "${currentVersion}" ]; then
    currentVersion=`bash ../common/getVersion.sh`
fi
baseImagesurl="fabius/"${appName}":"



#################################################################
##MySql
mysqlPassword="1234567"
docker stop mysql
docker rm mysql
docker run --name mysql -e MYSQL_ROOT_PASSWORD=${mysqlPassword} -v /home/fabius/data/mysql:/var/lib/mysql -d mysql:5.7


#################################################################
##WordPress
port=`bash ../azureCommon/allocatePort.sh wordpress ${appEnv}`
wordPressContainerName=${appName}_wordpress_${appEnv}
docker stop ${wordPressContainerName}
docker rm ${wordPressContainerName}
docker run -p ${port}:80 --name ${wordPressContainerName} --link mysql:mysql -e WORDPRESS_DB_HOST=mysql -e WORDPRESS_DB_PASSWORD=${mysqlPassword} -e WORDPRESS_DB_NAME=wordpress_${appEnv} -d wordpress:4.8.3-apache


#################################################################
##Web component

#1. Stop original
webContainerName=${appName}_web_${appEnv}

docker stop ${webContainerName}
docker rm ${webContainerName}

#2. Get all new images
webImageName=${baseImagesurl}web_${currentVersion}
docker rmi ${webImageName}
docker pull ${webImageName}

#3. Launch images per sequence
port=`bash ../azureCommon/allocatePort.sh web ${appEnv}`
docker run --link ${wordPressContainerName}:mywordpress -p ${port}:80 --name ${webContainerName} -d ${webImageName}
