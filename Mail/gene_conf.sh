#!/bin/bash

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
