FROM ubuntu:16.04

RUN echo "mysql-server mysql-server/root_password password test0155" | debconf-set-selections
RUN echo "mysql-server mysql-server/root_password_again password test0155" | debconf-set-selections



RUN apt-get update -y && \
	apt-get install -y mysql-server



ADD init.sh  /tmp/
ADD run.sh /temp/
ADD db_shema.sql /temp/
COPY mysqld.cnf /etc/mysql/mysql.conf.d/


RUN chmod +x /tmp/init.sh && chmod +x /tmp/run.sh
RUN /tmp/init.sh


EXPOSE 3306/tcp


ENTRYPOINT "/tmp/run.sh"