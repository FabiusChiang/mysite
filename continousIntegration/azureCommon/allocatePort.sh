#!/bin/bash

componentName=$1
appEnv=$2

port=8080

if [ "web" = "${componentName}" ]; then
    case "${appEnv}" in
        prod)
            port=80
            ;;
        qa)
            port=8081
            ;;
        *)
            exit 1
    esac
fi


echo ${port}