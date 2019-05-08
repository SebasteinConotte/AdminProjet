#!/bin/bash

# Initialize data directory
DATA_DIR=/data
if [ ! -f $DATA_DIR/mysql ]; then
    mysql_install_db
fi

# Initialize first run
if [[ -e /.firstrun ]]; then
    /script/create_database.sh
fi

# Start MySQL
echo "Starting MySQL..."
/usr/sbin/mysqld
