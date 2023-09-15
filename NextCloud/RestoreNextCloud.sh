#!/bin/bash

databasepass=`cat /root/passwords/databasepass.txt`

echo "Enter full path to nextcloud files backup:"
read nextcloudbackup

echo "Enter full path to nextcloud database backup:"
read nextclouddbbackup

if [ ! -f "$nextcloudibackup" ]; then
    echo "$nextcloudbackup does not exist."
    exit 1
fi

if [ ! -f "$nextclouddbbackup" ]; then
    echo "$nextclouddbbackup does not exist."
    exit 1
fi

mysql -u root -p$databasepass -e "create database nextcloud"; 
mysql -u root -p$databasepass nextcloud < $medianextcloudbackup

tar -xvf $nextcloudbackup -C /opt/DockerSwarmData

