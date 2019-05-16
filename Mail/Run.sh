#!/bin/bash

#start postfix
service sendmail stop
chkconfig sendmail off
chkconfig postfix on
service postfix start


# start dovecot
chkconfig dovecot on
service dovecot start