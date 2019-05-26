#!/bin/bash

service mysql start



mysql -u root --password=test0155
mysql --password=test0155 < /tmp/db_schema.sql


mysqladmin --password=test0155 shutdown