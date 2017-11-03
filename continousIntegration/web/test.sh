#!/bin/bash

sed -i -e "/Listen 80/s/Listen 80/Listen 8000/" \
    -e '/ssl_module/s/^#//' \
    -e '/proxy_module/s/^#//' \
    -e '/proxy_http_module/s/^#//' \
    -e '/rewrite_module/s/^#//' \
    -e '$aInclude conf/eams/*.conf' test.conf