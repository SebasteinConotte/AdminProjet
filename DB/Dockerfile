FROM ubuntu:14.04
# Disable any prompts for apt-get
ENV DEBIAN_FRONTEND noninteractive



# Get some security updates
RUN apt-get update
RUN apt-get -y upgrade



# See readme.md for more information about the accounts and passwords
#
RUN echo "mysql-server mysql-server/root_password password root" | debconf-set-selections
RUN echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections



# install mysql
RUN apt-get -y install mysql-server


# add our my.cnf and setup script
ADD https://raw.githubusercontent.com/SebasteinConotte/AdminProjet/master/DB/script/my.cnf /etc/mysql/my.cnf
ADD https://raw.githubusercontent.com/SebasteinConotte/AdminProjet/master/DB/script/setup.sh /home/setup.sh
ADD https://raw.githubusercontent.com/SebasteinConotte/AdminProjet/master/DB/script/db_shema.sql /home/db_shema.sql
RUN chmod +x /home/db_shema.sql
RUN chmod +x /home/setup.sh





# Define working directory.
WORKDIR /var/lib/mysql



# expose service port
EXPOSE 3306



CMD ["/home/setup.sh"]