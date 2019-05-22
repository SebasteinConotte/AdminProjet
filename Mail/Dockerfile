FROM ubuntu

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y &&\
	apt-get install postfix mailutils bsd-mailx mutt -y && \
	apt-get install dovecot-imapd dovecot-pop3d  mysql-server dovecot-mysql sasl2-bin cyrus-imapd-2.4 -y 
	
	

#configuration base de données
ADD https://raw.githubusercontent.com/SebasteinConotte/AdminProjet/master/Mail/install_db.sh install_db.sh
RUN chmod +x install_db.sh
RUN sed -i -e 's/\r$//' install_db.sh
RUN ./install_db.sh
	
#configuration droit postfix
RUN chmod o= /etc/postfix/mysql-virtual_*.cf && \
	chgrp postfix /etc/postfix/mysql-virtual_*.cf && \
	groupadd -g 5000 vmail && \
	useradd -g vmail -u 5000 vmail -d /home/vmail -m
	
	
RUN postconf -e 'myhostname = mail.w15.ephec-ti.be'  && \
	postconf -e 'mydestination = localhost'  && \
	postconf -e 'mynetworks = 127.0.0.0/8'  && \
	postconf -e 'inet_interfaces = all'  && \
	postconf -e 'message_size_limit = 30720000'  && \
	postconf -e 'virtual_alias_domains ='  && \
	postconf -e 'virtual_alias_maps = proxy:mysql:/etc/postfix/mysql-virtual_forwardings.cf, mysql:/etc/postfix/mysql-virtual_email2email.cf'  && \
	postconf -e 'virtual_mailbox_domains = proxy:mysql:/etc/postfix/mysql-virtual_domains.cf'  && \
	postconf -e 'virtual_mailbox_maps = proxy:mysql:/etc/postfix/mysql-virtual_mailboxes.cf'  && \
	postconf -e 'virtual_mailbox_base = /home/vmail'  && \
	postconf -e 'virtual_uid_maps = static:5000'  && \
	postconf -e 'virtual_gid_maps = static:5000'  && \
	postconf -e 'smtpd_sasl_type = dovecot'  && \
	postconf -e 'smtpd_sasl_path = private/auth'  && \
	postconf -e 'smtpd_sasl_auth_enable = yes'  && \
	postconf -e 'broken_sasl_auth_clients = yes'  && \
	postconf -e 'smtpd_sasl_authenticated_header = yes'  && \
	postconf -e 'smtpd_recipient_restrictions = permit_mynetworks, permit_sasl_authenticated, reject_unauth_destination'  && \
	postconf -e 'smtpd_use_tls = yes'  && \
	postconf -e 'smtpd_tls_cert_file = /etc/pki/dovecot/certs/dovecot.pem'  && \
	postconf -e 'smtpd_tls_key_file = /etc/pki/dovecot/private/dovecot.pem'  && \
	postconf -e 'virtual_create_maildirsize = yes'  && \
	postconf -e 'virtual_maildir_extended = yes'  && \
	postconf -e 'proxy_read_maps = $local_recipient_maps $mydestination $virtual_alias_maps $virtual_alias_domains $virtual_mailbox_maps $virtual_mailbox_domains $relay_recipient_maps $relay_domains $canonical_maps $sender_canonical_maps $recipient_canonical_maps $relocated_maps $transport_maps $mynetworks $virtual_mailbox_limit_maps'  && \
	postconf -e 'virtual_transport = virtual'  && \
	postconf -e 'dovecot_destination_recipient_limit = 1' 
	
RUN echo "dovecot   unix  -       n       n       -       -       pipe  flags=DRhu user=vmail:vmail argv=/usr/libexec/dovecot/deliver -f ${sender} -d ${recipient}" >> /etc/postfix/master.cf	

#backup dovecot.conf
RUN mv /etc/dovecot/dovecot.conf /etc/dovecot/dovecot.conf-backup

#configuration dovecot
ADD https://raw.githubusercontent.com/SebasteinConotte/AdminProjet/master/Mail/config_dovecot/dovecot.conf /etc/dovecot/dovecot.conf
ADD https://raw.githubusercontent.com/SebasteinConotte/AdminProjet/master/Mail/config_dovecot/dovecot-sql.conf /etc/dovecot/dovecot-sql.conf

#configuration droit dovecot
RUN chgrp dovecot /etc/dovecot/dovecot-sql.conf && \
	chmod o= /etc/dovecot/dovecot-sql.conf
	
ADD https://github.com/SebasteinConotte/AdminProjet/blob/master/Mail/Run.sh Run.sh
RUN chmod +x Run.sh
RUN sed -i -e 's/\r$//' Run.sh
	
CMD ./Run.sh
