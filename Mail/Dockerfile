FROM debian:stretch


# Installation
RUN apt-get update && apt-get upgrade -y

# Requirements
RUN apt-get install postfix -y && \
    apt-get install dovecot-core dovecot-imapd dovecot-pop3d -y && \
    apt-get install libsasl2-2 libsasl2-modules sasl2-bin -y && \
    apt-get install rsyslog mailutils -y

# Configuring postfix user
RUN groupadd -g 5000 vmail && \
    useradd -s /usr/sbin/nologin -u 5000 -g 5000 vmail && \
    usermod -aG vmail postfix && \
    usermod -aG vmail dovecot

# Create directories and files
RUN mkdir /etc/dovecot/ssl && \
    mkdir /mail-server && \
    mkdir /mail-server/scripts && \
    touch /var/log/dovecot && \
    chgrp vmail /var/log/dovecot && \
    chmod 660 /var/log/dovecot && \
    touch /etc/postfix/virtual_mailbox && \
    touch /etc/postfix/virtual_domains && \
    touch /etc/postfix/virtual_mailbox && \
    touch /etc/postfix/virtual_alias

WORKDIR /etc/dovecot/ssl
RUN openssl req -new -outform PEM -out smtpd.cert -newkey rsa:2048 -nodes \
  -keyout smtpd.key -keyform PEM -days 365 -x509 \
  -subj "/C=BE/ST=Wavre/L=Wavre/O=WoodyToys/OU=IT Department/CN=w15.ephec-ti.be"  
  
  
 
# Copy templates
COPY templates/postfix/main.cf /etc/postfix/main.cf
COPY templates/postfix/master.cf /etc/postfix/master.cf
COPY templates/dovecot/dovecot.conf /etc/dovecot/dovecot.conf

# Copy scripts
COPY scripts/ /mail-server/scripts/
RUN chmod +x /mail-server/scripts/*

# ENV variables
ENV DOMAIN ""
ENV USERNAME ""
ENV PASSWORD ""

# Volumes for configuration
VOLUME /var/spool/mail/vhosts

RUN chmod +x /var/spool/mail/vhosts

# Expose volumes
EXPOSE 25
EXPOSE 143

# Launching command
CMD /mail-server/scripts/docker-entryfile.sh
