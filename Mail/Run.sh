#!/bin/bash

#start postfix
service sendmail stop
service postfix start


# start dovecot
service dovecot start