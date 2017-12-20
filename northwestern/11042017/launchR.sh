#!/bin/bash

scriptFile=$1
outputFile=$2

folderOfCurrentScript="$(dirname "${BASH_SOURCE}")"
cd ${folderOfCurrentScript}
currentDir=`pwd`

R CMD BATCH ${scriptFile} ${outputFile}

cat ${outputFile}
