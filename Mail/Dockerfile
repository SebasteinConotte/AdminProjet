FROM debian:latest


ENV DEBIAN_FRONTEND noninteractive

RUN apt-get install -y supervisor postfix dovecot-core dovecot-pop3d dovecot-imapd

RUN groupadd -g 5000 vmail && useradd -s /usr/sbin/nologin -u 5000 -g 5000 vmail && \
	usermod -aG vmail postfix && \
	usermod -aG vmail dovecot && \
	mkdir -p /var/mail/vhosts/example.com && \
	chown -R vmail:vmail /var/mail/vhosts && \
	chmod -R 775 /var/mail/vhosts && \
	touch /var/log/dovecot && \
	chgrp vmail /var/log/dovecot && \
	chmod 660 /var/log/dovecot && \
	echo "w15.ephec-ti.be" >> /etc/postfix/virtual_domains && \
	mkdir /etc/dovecot/ssl && \
	cd /etc/dovecot/ssl && \
	openssl req -new -newkey rsa:3072 -nodes -keyout mailserver.key -days 9999 -x509 -out mailserver.crt 

ADD "lien" /etc/manguser/install.sh	
ADD "lien" /etc/manguser/create_user.sh	
ADD "lien" /etc/postfix/main.cf
ADD "lien" /etc/dovecot/dovecot.conf
ADD "lien" /etc/postfix/master.cf

RUN cd /etc/manguser/
RUN ./create_user.sh a.lemaire@w15.ephec-ti.be dfq154dgf5
RUN ./create_user.sh t.vanden@w15.ephec-ti.be  g55z4f5y4t

EXPOSE 25 143 110 587 993

CMD /install.sh;/usr/bin/supervisord -c /etc/supervisor/supervisord.conf


