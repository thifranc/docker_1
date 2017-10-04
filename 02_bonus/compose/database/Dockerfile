FROM postgres:9.6.2

VOLUME ["/database"]

USER postgres

COPY ./dump.sql /docker-entrypoint-initdb.d/

EXPOSE 5432
