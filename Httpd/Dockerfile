# Étape 1 : Build de l'application front-end avec Node.js
FROM node:18-alpine AS build-stage
WORKDIR /app
COPY devops-front-main/devops-front-main/package*.json ./
RUN npm install
COPY devops-front-main/devops-front-main/ ./
RUN npm run build

# Étape 2 : Serveur HTTP Apache pour servir les fichiers statiques et faire proxy
FROM httpd:alpine
# Copie des fichiers buildés du front-end vers le dossier public d'Apache
COPY --from=build-stage /app/dist /usr/local/apache2/htdocs/

# Copie de la configuration Apache et de l'entrypoint
COPY httpd.conf /usr/local/apache2/conf/httpd.conf
COPY entrypoint.sh /usr/local/apache2/bin/entrypoint.sh
RUN chmod +x /usr/local/apache2/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/apache2/bin/entrypoint.sh"]