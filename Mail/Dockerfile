FROM debian:latest


ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get upgrade && apt-get install -y supervisor postfix dovecot-core dovecot-pop3d dovecot-imapd

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

ADD https://raw.githubusercontent.com/SebasteinConotte/AdminProjet/master/Mail/install.sh /etc/manguser/install.sh	
ADD https://raw.githubusercontent.com/SebasteinConotte/AdminProjet/master/Mail/config/create_user.sh /etc/manguser/create_user.sh	
ADD https://raw.githubusercontent.com/SebasteinConotte/AdminProjet/master/Mail/config/main.cf /etc/postfix/main.cf
ADD https://raw.githubusercontent.com/SebasteinConotte/AdminProjet/master/Mail/config/dovecot.conf /etc/dovecot/dovecot.conf
ADD https://raw.githubusercontent.com/SebasteinConotte/AdminProjet/master/Mail/config/master.cf /etc/postfix/master.cf

RUN cd /etc/manguser/
RUN ./create_user.sh a.lemaire@w15.ephec-ti.be dfq154dgf5
RUN ./create_user.sh t.vanden@w15.ephec-ti.be  g55z4f5y4t

EXPOSE 25 143 110 587 993

CMD /install.sh;/usr/bin/supervisord -c /etc/supervisor/supervisord.conf


