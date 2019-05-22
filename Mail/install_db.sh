#!/bin/bash

/etc/init.d/mysql start

mysqladmin -u uroot password d83jf734g8
mysql -u uroot -p pd83jf734g8

# create database and apply permissions
mysql> CREATE DATABASE mail;  
mysql> use mail  
mysql> GRANT SELECT, INSERT, UPDATE, DELETE ON mail.* TO 'mail_admin'@'localhost' IDENTIFIED BY 'password';  
mysql> GRANT SELECT, INSERT, UPDATE, DELETE ON mail.* TO 'mail_admin'@'localhost.localdomain' IDENTIFIED BY 'password';  
mysql> FLUSH PRIVILEGES;

# create required tables
mysql> CREATE TABLE domains (domain varchar(50) NOT NULL, PRIMARY KEY (domain) );  
mysql> CREATE TABLE forwardings (source varchar(80) NOT NULL, destination TEXT NOT NULL, PRIMARY KEY (source) );  
mysql> CREATE TABLE users (email varchar(80) NOT NULL, password varchar(20) NOT NULL, PRIMARY KEY (email) );  
mysql> CREATE TABLE transport ( domain varchar(128) NOT NULL default '', transport varchar(128) NOT NULL default '', UNIQUE KEY domain (domain) );  

# create first mail account
mysql> INSERT INTO domains (domain) VALUES ('w15.ephec-ti.be');  
mysql> INSERT INTO users (email, password) VALUES ('l.lemaire@w15.ephec-ti.be', ENCRYPT('password'));  
mysql> quit 

# generate postfix mysql configuration
cat > /etc/postfix/mysql-virtual_domains.cf << EOF
user = mail_admin  
password = password  
dbname = mail  
query = SELECT domain AS virtual FROM domains WHERE domain='%s'  
hosts = 127.0.0.1  
EOF  

cat > /etc/postfix/mysql-virtual_forwardings.cf << EOF
user = mail_admin  
password = password  
dbname = mail  
query = SELECT destination FROM forwardings WHERE source='%s'  
hosts = 127.0.0.1  
EOF  

cat > /etc/postfix/mysql-virtual_mailboxes.cf << EOF
user = mail_admin  
password = password  
dbname = mail  
query = SELECT CONCAT(SUBSTRING_INDEX(email,'@',-1),'/',SUBSTRING_INDEX(email,'@',1),'/') FROM users WHERE email='%s'  
hosts = 127.0.0.1  
EOF  

cat > /etc/postfix/mysql-virtual_email2email.cf << EOF
user = mail_admin  
password = password  
dbname = mail  
query = SELECT email FROM users WHERE email='%s'  
hosts = 127.0.0.1  
EOF 

