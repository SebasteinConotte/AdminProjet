FROM debian:stretch


ENV MYSQL_USERNAME mail_admin
ENV MYSQL_PASSWORD "secret"
ENV MYSQL_DBNAME   mailserver

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update

RUN apt-get update && \
  apt-get install --assume-yes apt-utils && \
  apt-get upgrade -y && \
  apt-get install -y postfix \
    postfix-mysql \
    mysql-client \
    mysql-server \
    dovecot-common \
	dovecot-lmtpd \
	dovecot-core \
	dovecot-pop3d \
	dovecot-lmtpd \
    dovecot-imapd \
    dovecot-sieve \
    dovecot-managesieved \
    dovecot-mysql \
    libsasl2-2 \
    libsasl2-modules \
    libsasl2-modules-sql \
    sasl2-bin \
    libpam-mysql \
    openssl \
    mailutils \
    supervisor

RUN sed -i 's/127.0.0.1/0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf
COPY cfg/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ENV Q1 CREATE DATABASE $MYSQL_DBNAME;\
    USE $MYSQL_DBNAME;\
    GRANT SELECT, INSERT, UPDATE, DELETE ON $MYSQL_DBNAME.* TO $MYSQL_USERNAME@\'%\' IDENTIFIED BY \'$MYSQL_PASSWORD\'; \
    GRANT SELECT, INSERT, UPDATE, DELETE ON $MYSQL_DBNAME.* TO $MYSQL_USERNAME@localhost.localdomain IDENTIFIED BY \'$MYSQL_PASSWORD\'; \
    FLUSH PRIVILEGES; \
	CREATE TABLE `virtual_domains` (`id` int(11) NOT NULL auto_increment,`name` varchar(50) NOT NULL,PRIMARY KEY (`id`)) ENGINE=InnoDB DEFAULT CHARSET=utf8; \
	CREATE TABLE `virtual_users` (`id` int(11) NOT NULL auto_increment,`domain_id` int(11) NOT NULL,`password` varchar(106) NOT NULL,`email` varchar(100) NOT NULL,PRIMARY KEY (`id`),UNIQUE KEY `email` (`email`),FOREIGN KEY (domain_id) REFERENCES virtual_domains(id) ON DELETE CASCADE ) ENGINE=InnoDB DEFAULT CHARSET=utf8; \
	CREATE TABLE `virtual_aliases` (`id` int(11) NOT NULL auto_increment,`domain_id` int(11) NOT NULL,`source` varchar(100) NOT NULL,`destination` varchar(100) NOT NULL,PRIMARY KEY (`id`),FOREIGN KEY (domain_id) REFERENCES virtual_domains(id) ON DELETE CASCADE) ENGINE=InnoDB DEFAULT CHARSET=utf8;
	
RUN service mysql start && \
  mysql -u root -e "$Q1"

COPY cfg/mysql-virtual_domains.cf /etc/postfix/

RUN sed -i 's/user = mail_admin/user = '"$MYSQL_USERNAME"'/' /etc/postfix/mysql-virtual_domains.cf
RUN sed -i 's/password = mail_admin_password/password = '"$MYSQL_PASSWORD"'/' /etc/postfix/mysql-virtual_domains.cf
RUN sed -i 's/dbname = mail/dbname = '"$MYSQL_DBNAME"'/' /etc/postfix/mysql-virtual_domains.cf

COPY cfg/mysql-virtual_forwardings.cf /etc/postfix/

RUN sed -i 's/user = mail_admin/user = '"$MYSQL_USERNAME"'/' /etc/postfix/mysql-virtual_forwardings.cf
RUN sed -i 's/password = mail_admin_password/password = '"$MYSQL_PASSWORD"'/' /etc/postfix/mysql-virtual_forwardings.cf
RUN sed -i 's/dbname = mail/dbname = '"$MYSQL_DBNAME"'/' /etc/postfix/mysql-virtual_forwardings.cf

COPY cfg/mysql-virtual_mailboxes.cf /etc/postfix/

RUN sed -i 's/user = mail_admin/user = '"$MYSQL_USERNAME"'/' /etc/postfix/mysql-virtual_mailboxes.cf
RUN sed -i 's/password = mail_admin_password/password = '"$MYSQL_PASSWORD"'/' /etc/postfix/mysql-virtual_mailboxes.cf
RUN sed -i 's/dbname = mail/dbname = '"$MYSQL_DBNAME"'/' /etc/postfix/mysql-virtual_mailboxes.cf

COPY cfg/mysql-virtual_email2email.cf /etc/postfix/

RUN sed -i 's/user = mail_admin/user = '"$MYSQL_USERNAME"'/' /etc/postfix/mysql-virtual_email2email.cf
RUN sed -i 's/password = mail_admin_password/password = '"$MYSQL_PASSWORD"'/' /etc/postfix/mysql-virtual_email2email.cf
RUN sed -i 's/dbname = mail/dbname = '"$MYSQL_DBNAME"'/' /etc/postfix/mysql-virtual_email2email.cf

RUN chmod o= /etc/postfix/mysql-virtual_*.cf && \
  chgrp postfix /etc/postfix/mysql-virtual_*.cf && \
  mkdir -p /var/mail/vhosts/w15.ephec-ti.be && \
  groupadd -g 5000 vmail && \
  useradd -g vmail -u 5000 vmail -d /var/vmail -m && \
  chown -R vmail:vmail /var/mail

COPY cfg/main.cf /etc/postfix/main.cf

WORKDIR /etc/postfix
RUN openssl req -new -outform PEM -out smtpd.cert -newkey rsa:2048 -nodes \
  -keyout smtpd.key -keyform PEM -days 365 -x509 \
  -subj "/C=BE/ST=Wavre/L=Wavre/O=WoodyToys/OU=IT Department/CN=w15.ephec-ti.be"
  
RUN chmod o= /etc/postfix/smtpd.key

RUN mkdir -p /var/spool/postfix/var/run/saslauthd
RUN cp -a /etc/default/saslauthd /etc/default/saslauthd.bak

RUN sed -i 's/START=no/START=yes/' /etc/default/saslauthd
RUN sed -i 's#OPTIONS=".*"#OPTIONS="-c -m /var/spool/postfix/var/run/saslauthd -r"#' /etc/default/saslauthd

COPY cfg/smtp /etc/pam.d/
COPY cfg/smtpd.conf /etc/postfix/sasl/

RUN sed -i 's/sql_user: mail_admin/sql_user: '"$MYSQL_USERNAME"'/' /etc/postfix/sasl/smtpd.conf
RUN sed -i 's/sql_passwd: mail_admin_password/sql_passwd: '"$MYSQL_PASSWORD"'/' /etc/postfix/sasl/smtpd.conf
RUN sed -i 's/sql_database: mail/sql_passwd: '"$MYSQL_DBNAME"'/' /etc/postfix/sasl/smtpd.conf

RUN chmod o= /etc/pam.d/smtp && \
  chmod o= /etc/postfix/sasl/smtpd.conf && \
  adduser postfix sasl

COPY  cfg/master.cf /etc/postfix/master.cf

COPY cfg/dovecot.conf /etc/dovecot/dovecot.conf
COPY cfg/10-auth.conf /etc/dovecot/conf.d/10-auth.conf
COPY cfg/10-mail.conf /etc/dovecot/conf.d/10-mail.conf
COPY cfg/10-master.conf /etc/dovecot/conf.d/10-master.conf
COPY cfg/auth-sql.conf.ext /etc/dovecot/conf.d/auth-sql.conf.ext
COPY cfg/dovecot-sql.conf.ext /etc/dovecot/dovecot-sql.conf.ext
COPY cfg/10-ssl.conf /etc/dovecot/conf.d/10-ssl.conf



RUN chown -R vmail:dovecot /etc/dovecot && \
	chmod -R o-rwx /etc/dovecot


RUN service mysql start && \
  mysql -u root -e "USE mailserver; \
    INSERT INTO `virtual_domains`(`id` ,`name`) VALUES ('1', 'w15.ephec-ti.be'); \
    INSERT INTO `virtual_users`(`id`, `domain_id`, `password` , `email`) VALUES ('1', '1', ENCRYPT('password', CONCAT('$6$', SUBSTRING(SHA(RAND()), -16))), 'l.lemaire@w15.ephec-ti.be'),('2', '1', ENCRYPT('admin_password', CONCAT('$6$', SUBSTRING(SHA(RAND()), -16))), 'admin@w15.ephec-ti.be'); \
	INSERT INTO `virtual_aliases`(`id`, `domain_id`, `source`, `destination`) VALUES ('1', '1', 'contact@w15.ephec-ti.be', 'l.lemaire@w15.ephec-ti.be');"

EXPOSE 995
EXPOSE 993
EXPOSE 587
EXPOSE 3306

CMD ["/usr/bin/supervisord"]