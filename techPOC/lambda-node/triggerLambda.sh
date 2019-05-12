#!/bin/bash

aws lambda invoke-async --function-name testAsync --invoke-args "package.json" \
& aws lambda invoke-async --function-name testAsync --invoke-args "package.json" \
& aws lambda invoke-async --function-name testAsync --invoke-args "package.json" \
& aws lambda invoke-async --function-name testAsync --invoke-args "package.json"