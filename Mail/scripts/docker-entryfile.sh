#!/bin/bash

# Launch configuration script
/mail-server/scripts/configure.sh

# Launch services
service rsyslog start
service postfix start
service dovecot start

# Launch logs examination
tail -f /var/log/dovecot
