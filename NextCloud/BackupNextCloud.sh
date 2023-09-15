#!/bin/bash -x

databasepass=`cat /root/passwords/databasepass.txt`

mkdir /mnt/backups
mkdir /mnt/backups/nextcloud

DATE=`date +%F`
FILENAME=nextcloud-$DATE.tar.gz
SRCDIR=/opt/DockerSwarmData
DESTDIR=/mnt/backups/nextcloud
tar --gzip -cf "$DESTDIR/$FILENAME" -C $SRCDIR nextcloud

FILENAMEDB=nextclouddb-$DATE.sql

mysqldump -u root -p$databasepass nextcloud > "$DESTDIR/$FILENAMEDB"

## Delete older backups
find "$DESTDIR/$FILENAME" -type f -mtime +10 -delete
find "$DESTDIR/$FILENAMEDB" -type f -mtime +10 -delete
