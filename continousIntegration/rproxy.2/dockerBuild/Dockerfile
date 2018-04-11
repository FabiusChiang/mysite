FROM httpd:2.2

ADD httpd.conf /usr/local/apache2/conf/
ADD proxy.conf /usr/local/apache2/conf/
ADD httpd-ssl.sample.conf /usr/local/apache2/conf/extra/httpd-ssl.conf

ADD client.cer /usr/local/apache2/conf/client.cer

ADD server.crt /usr/local/apache2/conf/
ADD server.key /usr/local/apache2/conf/