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

if [ "wordpress" = "${componentName}" ]; then
    case "${appEnv}" in
        prod)
            port=7090
            ;;
        qa)
            port=7091
            ;;
        dev)
            port=7092
            ;;
        *)
            exit 1
    esac
fi


echo ${port}