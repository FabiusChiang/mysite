#!/bin/bash

appEnv=$1
currentVersion=$2

############Make enter the root folder of all script
folderOfCurrentScript="$(dirname "${BASH_SOURCE}")"
cd ${folderOfCurrentScript}

source ../../../credentials.sh

appName="mysite"
if [ -z "${currentVersion}" ]; then
    currentVersion=`bash ../common/getVersion.sh`
fi
baseImagesurl="fabius/"${appName}":"


#################################################################
##MySql
# mysqlPassword="1234567"
# docker stop mysql
# docker rm mysql
# docker run --name mysql -e MYSQL_ROOT_PASSWORD=${mysqlPassword} -v /home/fabius/data/mysql:/var/lib/mysql -d mysql:5.7


#################################################################
##WordPress
port=`bash ../azureCommon/allocatePort.sh wordpress ${appEnv}`
wordPressContainerName=${appName}_wordpress_${appEnv}
docker stop ${wordPressContainerName}
docker rm ${wordPressContainerName}
echo ${hostName}
echo ${userName}
#docker run -p ${port}:80 --name ${wordPressContainerName} -e WORDPRESS_DB_HOST=${hostName} -e WORDPRESS_DB_PASSWORD="${specialPass}" -e WORDPRESS_DB_NAME=wordpress_${appEnv} -d wordpress:4.8.3-apache
docker run -p ${port}:80 --name ${wordPressContainerName} -e WORDPRESS_DB_HOST=${hostName} -e WORDPRESS_DB_PASSWORD="${specialPass}" -e WORDPRESS_DB_NAME=wordpress_${appEnv} -e WORDPRESS_DB_USER="${userName}" -d wordpress:4.8.3-apache



#################################################################
##Web component

#1. Stop original
webContainerName=${appName}_web

docker stop ${webContainerName}
docker rm ${webContainerName}

#2. Get all new images
webImageName=${baseImagesurl}web_${currentVersion}
docker rmi ${webImageName}
docker pull ${webImageName}

#3. Launch images per sequence
# port=`bash ../azureCommon/allocatePort.sh web ${appEnv}`
# docker run --link ${wordPressContainerName}:mywordpress -p ${port}:80 --name ${webContainerName} -d ${webImageName}

docker run -p 80:80 -v /home/fabius/data/static:/usr/local/apache2/htdocs/static --name ${webContainerName} -d ${webImageName}
