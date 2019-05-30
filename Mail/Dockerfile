FROM ubuntu:14.04

RUN apt-get update
RUN apt-get install -y postfix postfix-mysql dovecot-common dovecot-pop3d dovecot-imapd openssl dovecot-mysql mysql-server mysql-client libpam-mysql
ADD postfix /etc/postfix
ADD dovecot /etc/dovecot

ENV DB_HOST localhost
ENV DB_USER admin_mail 
ENV DB_PASSWORD secret
ENV DB_NAME mailserver
ENV APP_HOST mail.w15.ephec-ti.be

RUN groupadd -g 5000 vmail && \
    useradd -g vmail -u 5000 vmail -d /home/vmail -m && \
    chgrp postfix /etc/postfix/mysql-*.cf && \
    chgrp vmail /etc/dovecot/dovecot.conf && \
    chmod g+r /etc/dovecot/dovecot.conf

RUN sed -i 's/127.0.0.1/0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf


   
RUN service mysql start && \
  mysql -u root < shema_sql/mySQL.sql


RUN postconf -e virtual_uid_maps=static:5000 && \
    postconf -e virtual_gid_maps=static:5000 && \
    postconf -e virtual_mailbox_domains=mysql:/etc/postfix/mysql-virtual-mailbox-domains.cf && \
    postconf -e virtual_mailbox_maps=mysql:/etc/postfix/mysql-virtual-mailbox-maps.cf && \
    postconf -e virtual_alias_maps=mysql:/etc/postfix/mysql-virtual-alias-maps.cf,mysql:/etc/postfix/mysql-email2email.cf && \
    postconf -e virtual_transport=dovecot && \
    postconf -e dovecot_destination_recipient_limit=1 && \
	postconf -F '*/*/chroot = n'
	

RUN echo "dovecot   unix  -       n       n       -       -       pipe"  >> /etc/postfix/master.cf && \
    echo '    flags=DRhu user=vmail:vmail argv=/usr/lib/dovecot/deliver -d ${recipient}' >> /etc/postfix/master.cf

	
ADD start.sh /start.sh	

WORKDIR /etc/postfix
RUN openssl req -new -outform PEM -out smtpd.cert -newkey rsa:2048 -nodes \
  -keyout smtpd.key -keyform PEM -days 365 -x509 \
  -subj "/C=BE/ST=Wavre/L=Wavre/O=WoodyToys/OU=IT Department/CN=w15.ephec-ti.be"
  
RUN chmod o= /etc/postfix/smtpd.key


# SMTP ports
EXPOSE 25
EXPOSE 587
  
# POP and IMAP ports  
EXPOSE 110
EXPOSE 143
EXPOSE 995
EXPOSE 993
EXPOSE 3306


RUN service mysql start 
 
CMD sh start.sh
