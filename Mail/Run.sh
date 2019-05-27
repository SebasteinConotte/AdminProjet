#!/bin/bash

#start postfix
service postfix start


# start dovecot
systemctl start dovecot.service