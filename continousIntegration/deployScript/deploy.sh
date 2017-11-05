#!/bin/bash

currentVersion=$1
appEnv=$2

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
docker run --name mysql -e MYSQL_ROOT_PASSWORD=${mysqlPassword} -v /home/fabius/data/mysql:/var/lib/mysql -d mysql:5.7


#################################################################
##WordPress
wordPressContainerName=${appName}_wordpress_${appEnv}
docker stop webContainerName
docker run --name wordPressContainerName --link mysql:mysql -e WORDPRESS_DB_HOST=mysql -e WORDPRESS_DB_PASSWORD=${mysqlPassword} -e WORDPRESS_DB_NAME=${wordpress}_${appEnv} -d wordpress:4.8.3-apache


#################################################################
##Web component

#1. Stop original
webContainerName=${appName}_web_${appEnv}

docker stop ${webContainerName}
docker rm ${webContainerName}

#2. Get all new images
webImageName=${baseImagesurl}web_${currentVersion}
docker rmi webImageName
docker pull ${webImageName}

#3. Launch images per sequence
port=`bash ../azureCommon/allocatePort.sh web ${appEnv}`
docker run --link mywordpress:${wordPressContainerName} -p ${port}:80 --name ${webContainerName} -d ${webImageName}
