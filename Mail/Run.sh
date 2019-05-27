#!/bin/bash

#start postfix
service postfix restart


# start dovecot
/usr/sbin/dovecot -F