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

RUN mysql_install_db

USER mysql

CMD ["mysqld_safe", "--init-file=script/db_shema.sql", "--skip-name-resolve"]

EXPOSE 3306
