FROM ubuntu:16.04


# Install MySQL 5.7
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update &&\
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --force-yes \
    mysql-server-5.7 && \
    service mysql stop && \
    sed -e 's/^bind-address\t.*$/bind-address = 51.77.203.89/' -i /etc/mysql/my.cnf && \
    apt-get clean 

RUN mkdir -p /var/run/mysqld
RUN chown mysql:mysql /var/run/mysqld
RUN mkdir script && mkdir data
COPY /script/db_shema.sql /script/db_shema.sql
RUN mysqld --initialize-insecure --user=mysql --datadir=data/

USER mysql

CMD ["mysqld_safe", "--init-file=script/db_shema.sql", "--skip-name-resolve"]

EXPOSE 3306
