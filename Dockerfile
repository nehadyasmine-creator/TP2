FROM postgres:17.2-alpine
COPY ./init/ /docker-entrypoint-initdb.d/

ENV POSTGRES_DB=db \
   POSTGRES_USER=usr \
   POSTGRES_PASSWORD=pwd