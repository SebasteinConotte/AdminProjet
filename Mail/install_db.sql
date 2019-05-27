# create database and apply permissions
CREATE DATABASE mail;  
use mail  
GRANT SELECT, INSERT, UPDATE, DELETE ON mail.* TO 'mail_admin'@'localhost' IDENTIFIED BY 'password';  
GRANT SELECT, INSERT, UPDATE, DELETE ON mail.* TO 'mail_admin'@'localhost.localdomain' IDENTIFIED BY 'password';  
FLUSH PRIVILEGES;

# create required tables
CREATE TABLE domains (domain varchar(50) NOT NULL, PRIMARY KEY (domain) );  
CREATE TABLE forwardings (source varchar(80) NOT NULL, destination TEXT NOT NULL, PRIMARY KEY (source) );  
CREATE TABLE users (email varchar(80) NOT NULL, password varchar(20) NOT NULL, PRIMARY KEY (email) );  
CREATE TABLE transport ( domain varchar(128) NOT NULL default '', transport varchar(128) NOT NULL default '', UNIQUE KEY domain (domain) );  

# create first mail account
INSERT INTO domains (domain) VALUES ('w15.ephec-ti.be');  
INSERT INTO users (email, password) VALUES ('l.lemaire@w15.ephec-ti.be', ENCRYPT('password'));  


 

