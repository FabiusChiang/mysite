FROM ubuntu:16.04

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:certbot/certbot && \
    apt-get update && \
    apt-get install -y python-certbot-apache && \
    apt install -y python-pip  && \
    pip install certbot-dns-google