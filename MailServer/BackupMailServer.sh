#!/bin/bash -x

#databasepass=`cat /root/passwords/databasepass.txt`

mkdir /mnt/backups
mkdir /mnt/backups/sync/mailserver

DATE=`date +%F`
FILENAME=mailserver-$DATE.tar.gz
SRCDIR=/opt/DockerSwarmData
DESTDIR=/mnt/backups/sync/mailserver
tar --gzip -cf "$DESTDIR/$FILENAME" -C $SRCDIR mailserver

## Delete older backups
ls -t $DESTDIR/mailserver-*.tar.gz | tail -n +10 | xargs rm --
