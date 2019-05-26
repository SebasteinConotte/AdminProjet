
FROM centos:6.6
RUN yum -y install mysql-server-5.1.73

ADD "link" /etc/my.cnf
ADD "link" /db_shema.sql

RUN mysql_install_db

USER mysql

EXPOSE 3306

CMD ["mysqld_safe", "--init-file=/db_shema.sql", "--skip-name-resolve"]



