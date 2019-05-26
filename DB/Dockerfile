
FROM centos:6.6
RUN yum -y install mysql-server-5.1.73

ADD https://raw.githubusercontent.com/SebasteinConotte/AdminProjet/master/DB/script/my.cnf /etc/my.cnf
ADD https://raw.githubusercontent.com/SebasteinConotte/AdminProjet/master/DB/script/db_shema.sql /db_shema.sql

RUN mysql_install_db

USER mysql

EXPOSE 3306

CMD ["mysqld_safe", "--init-file=/db_shema.sql", "--skip-name-resolve"]



