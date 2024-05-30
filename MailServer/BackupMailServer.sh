#!/bin/bash -x

databasepass=`cat /root/passwords/databasepass.txt`

mkdir /mnt/backups
mkdir /mnt/backups/mailserver

DATE=`date +%F`
FILENAME=mailserver-$DATE.tar.gz
SRCDIR=/opt/DockerSwarmData
DESTDIR=/mnt/backups/mailserver
tar --gzip -cf "$DESTDIR/$FILENAME" -C $SRCDIR mailserver

## Delete older backups
find "$DESTDIR/" -name "mailserver*.tar.gz" -type f -mtime +10 -delete
