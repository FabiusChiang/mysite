FROM httpd:2.2

ADD httpd.conf /usr/local/apache2/conf/
ADD proxy.conf /usr/local/apache2/conf/
ADD vhost.conf /usr/local/apache2/conf/
ADD httpd-ssl.conf /usr/local/apache2/conf/

# ADD server.crt /usr/local/apache2/conf/
# ADD server.key /usr/local/apache2/conf/

ADD webRoot/* /usr/local/apache2/htdocs/
RUN chmod -R o+r /usr/local/apache2/htdocs