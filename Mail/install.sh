#!/bin/bash

#judgement
if [[ -a /etc/supervisor/conf.d/supervisord.conf ]]; then
  exit 0
fi

#supervisor
cat > /etc/supervisor/conf.d/supervisord.conf <<EOF
[supervisord]
nodaemon=true
[program:postfix]
command=/opt/postfix.sh
[program:dovecot]
command=/usr/sbin/dovecot
[program:rsyslog]
command=/usr/sbin/rsyslogd -n -c3
EOF
