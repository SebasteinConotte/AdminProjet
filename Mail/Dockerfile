FROM ubuntu:xenial


ENV MYSQL_USERNAME mail_admin
ENV MYSQL_PASSWORD "secret"
ENV MYSQL_DBNAME   mail

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update

RUN apt-get update && \
  apt-get install --assume-yes apt-utils && \
  apt-get upgrade -y && \
  apt-get install -y postfix \
    postfix-mysql \
	rsyslog \
	dovecot-lmtpd \
	dovecot-pop3d \
	dovecot-core \
    dovecot-imapd \
    dovecot-mysql \
    libsasl2-2 \
    libsasl2-modules \
    libsasl2-modules-sql \
    sasl2-bin \
    libpam-mysql \
    openssl \
    mailutils \
    supervisor \
	opendkim \
	opendkim-tools \
	libopendbx1-mysql \
	mariadb-server

RUN sed -i 's/127.0.0.1/0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf
ENV Q1 CREATE DATABASE $MYSQL_DBNAME;\
    USE $MYSQL_DBNAME;\
    GRANT SELECT, INSERT, UPDATE, DELETE ON $MYSQL_DBNAME.* TO $MYSQL_USERNAME@\'%\' IDENTIFIED BY \'$MYSQL_PASSWORD\'; \
    GRANT SELECT, INSERT, UPDATE, DELETE ON $MYSQL_DBNAME.* TO $MYSQL_USERNAME@localhost.localdomain IDENTIFIED BY \'$MYSQL_PASSWORD\'; \
    FLUSH PRIVILEGES; \
    CREATE TABLE `virtual_domains` (`id` int NOT NULL AUTO_INCREMENT,`name` varchar(50) NOT NULL,PRIMARY KEY (`id`),KEY (`name`)) ENGINE=InnoDB DEFAULT CHARSET=utf8; \
	CREATE TABLE `virtual_users` (`id` int NOT NULL AUTO_INCREMENT,`domain_id` int NOT NULL,`email` varchar(120) NOT NULL,`password` varchar(106) NOT NULL,`send_only` tinyint(1) NOT NULL DEFAULT 0,`active` tinyint(1) NOT NULL DEFAULT 1,PRIMARY KEY (`id`),UNIQUE KEY (`email`),KEY (`domain_id`),FOREIGN KEY (`domain_id`) REFERENCES `virtual_domains`(`id`) ON DELETE CASCADE) ENGINE=InnoDB DEFAULT CHARSET=utf8; \
	CREATE TABLE `virtual_aliases` (`id` int NOT NULL AUTO_INCREMENT,`domain_id` int NOT NULL,`source` varchar(100) NOT NULL,`destination` varchar(100) NOT NULL,PRIMARY KEY (`id`),KEY (`domain_id`),KEY (`source`),FOREIGN KEY (`domain_id`) REFERENCES `virtual_domains`(`id`) ON DELETE CASCADE) ENGINE=InnoDB DEFAULT CHARSET=utf8;
	
RUN service mysql start && \
  mysql -u root -e "$Q1"

RUN groupadd -g 5000 vmail && useradd -g vmail -u 5000 vmail -d /var/vmail

WORKDIR /etc/ssl/mailsrv
RUN openssl req -new -outform PEM -out smtpd.cert -newkey rsa:2048 -nodes \
  -keyout smtpd.key -keyform PEM -days 365 -x509 \
  -subj "/C=BE/ST=Wavre/L=Wavre/O=WoodyToys/OU=IT Department/CN=w15.ephec-ti.be"


COPY config/postfix/    /etc/postfix/
COPY config/dovecot/    /etc/dovecot/
COPY config/supervisor/ /etc/supervisor/
COPY config/etc/        /etc/



COPY scripts/* /usr/local/bin/
RUN chmod +x /usr/local/bin/*
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]



VOLUME [ "/var/vmail" ]
EXPOSE 25 110 143 465 587 993 995