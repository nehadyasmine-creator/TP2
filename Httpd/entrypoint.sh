#!/bin/sh
# Remplace le nom du backend dans le httpd.conf par la variable d'environnement BACKEND_HOST si elle existe, sinon 'backend'
sed -i "s/YOUR_BACKEND_LINK/${BACKEND_HOST:-backend}/g" /usr/local/apache2/conf/httpd.conf

# Lance le serveur httpd normalement
exec httpd -D FOREGROUND