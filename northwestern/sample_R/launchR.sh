#!/bin/bash

scriptFile=$1
outputFile=$2

R CMD ${scriptFile} ${outputFile}
