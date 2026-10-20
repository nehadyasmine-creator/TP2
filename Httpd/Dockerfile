FROM httpd:alpine
COPY index.html /usr/local/apache2/htdocs/index.html
COPY httpd.conf /usr/local/apache2/conf/httpd.conf
COPY entrypoint.sh /usr/local/apache2/bin/entrypoint.sh
RUN chmod +x /usr/local/apache2/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/apache2/bin/entrypoint.sh"]