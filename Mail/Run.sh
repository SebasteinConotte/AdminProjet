#!/bin/bash

#start postfix
service postfix restart


# start dovecot
systemctl restart dovecot