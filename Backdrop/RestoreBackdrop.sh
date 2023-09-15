#!/bin/bash

databasepass=`cat /root/passwords/databasepass.txt`

echo "Enter full path to Backdrop files backup:"
read backdropbackup

echo "Enter full path to Backdrop database backup:"
read backdropdbbackup

if [ ! -f "$backdropbackup" ]; then
    echo "$backdropbackup does not exist."
    exit 1
fi

if [ ! -f "$backdropdbbackup" ]; then
    echo "$backdropdbbackup does not exist."
    exit 1
fi

mysql -u root -p$databasepass -e "create database backdrop"; 
mysql -u root -p$databasepass backdrop < $backdropdbbackup

tar -xvf $backdropbackup -C /srv/www/htdocs

