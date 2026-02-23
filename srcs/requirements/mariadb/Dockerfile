FROM alpine:3.22

RUN apk update && apk add --no-cache mariadb mariadb-client  

RUN mkdir -p /run/mysqld /var/lib/mysql \
    && chown -R mysql:mysql /run/mysqld /var/lib/mysql

COPY my.cnf /etc/my.cnf.d/zzz-custom.cnf
COPY script.sh /script.sh
RUN chmod +x /script.sh

EXPOSE 3306

ENTRYPOINT ["/script.sh"]