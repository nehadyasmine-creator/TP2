# Pour quelle raison est-il préférable d'exécuter le conteneur avec un indicateur -e pour fournir les variables d'environnement plutôt que de les placer directement dans le Dockerfile ?

Il est préférable d'utiliser l'indicateur -e au moment de l'exécution pour des raisons de sécurité et de flexibilité :
- Sécurité : Éviter d'exposer les mots de passe et identifiants en clair
- Flexibilité : Permettre de réutiliser la même image Docker sur différents environnements

# Pourquoi avons-nous besoin d'un volume à attacher à notre conteneur postgres ?
Par défaut, les données écrites à l'intérieur d'un conteneur Docker sont stockées dans sa couche inscriptible éphémère. Si le conteneur est supprimé, toutes les données de la base de données sont définitivement perdues. 
L'utilisation d'un volume Docker permet de persister ces données sur le disque de la machine hôte.

# Documentation des éléments essentiels du conteneur de base de données :

Le Dockerfile :
FROM postgres:17.2-alpine
COPY ./init/ /docker-entrypoint-initdb.d/

**Les commandes principales :**

Construction de l'image :
docker build -t mon-postgres .

Création du réseau :
docker network create app-network

Lancement du conteneur avec volume et variables d'environnement :
docker run --name mon-postgres-container --net=app-network -v pgdata:/var/lib/postgresql/data -e POSTGRES_DB=db -e POSTGRES_USER=usr -e POSTGRES_PASSWORD=pwd -d mon-postgres

Lancement d'Adminer :
docker run -p "8090:8080" --net=app-network --name=adminer -d adminer

# Pourquoi avons-nous besoin d'une construction en plusieurs étapes (multi-stage build) ?
Une construction en plusieurs étapes permet de séparer l'environnement de compilation de l'environnement d'exécution final. Cela permet d'obtenir une image finale beaucoup plus légère, plus sécurisée et de s'affranchir de l'installation de Maven ou d'un JDK sur la machine hôte.

# Pourquoi avons-nous besoin d'un proxy inverse ?
Un proxy inverse placé entre les clients et les serveurs backend offre plusieurs avantages essentiels :
- Sécurité : masque l'architecture interne et les serveurs backend,
- Gestion centralisée : simplifie la configuration de la sécurité et peut gérer la compression, le cache.
- Équilibrage de charge : permet de répartir le trafic entrant sur plusieurs instances d'un backend
- Routage et hébergement multiple : permet de servir des fichiers statiques sur le même nom de domaine

# Pourquoi docker-compose est-il si important ?
Docker-compose est essentiel car il permet de définir, configurer et lancer plusieurs conteneurs interconnectés à l'aide d'un seul fichier de configuration (docker-compose.yml) et d'une seule commande (docker compose up). 

# Documentation des commandes les plus importantes de docker-compose
docker compose up -d : Construit et lance tous les services définis dans le fichier
docker compose down : Arrête et supprime tous les conteneurs, réseaux et objets 
docker compose logs -f : Affiche et suit en temps réel les journaux de tous les services
docker compose build : Reconstruit les images des services qui utilisent un Dockerfile.
docker compose ps : Liste les conteneurs gérés par le compose en cours d'exécution.

# Documentez votre fichier docker-compose
Le fichier docker-compose.yml structure l'application en trois services principaux (database, backend, httpd), relie ces services via un réseau virtuel privé (app-network), gère la persistance des données de PostgreSQL, et définit l'ordre de démarrage pour garantir que la base de données est prête avant que le backend ne démarre.

# Documentez vos commandes de publication et vos images publiées sur Docker Hub
Connexion : docker login

Étiquetage (tag) des images :
docker tag tp1-database yasminenhd/my-database:1.0
docker tag tp1-backend yasminenhd/my-api:1.0
docker tag tp1-httpd yasminenhd/my-httpd:1.0

Publication (push) :
docker push yasminenhd/my-database:1.0
docker push yasminenhd/my-api:1.0
docker push yasminenhd/my-httpd:1.0

# Pourquoi déposons-nous nos images dans un dépôt en ligne ?
Déposer nos images dans un registre en ligne (comme Docker Hub) permet de :
- Partager facilement le code et l'application avec les autres membres d'une équipe
- Déployer l'application de manière automatisée sur des serveurs distants, des environnements de test ou de production sans avoir à recompiler le code source sur chaque machine.
- Centraliser et versionner les différentes versions de l'application de manière sécurisée.