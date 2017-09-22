#!/bin/bash

targetEnv=$1

if [ "dr" = "${targetEnv}" ]; then
    echo "us-west-2"
else
    echo "us-east-1"
fi