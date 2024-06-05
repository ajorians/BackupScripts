#!/bin/bash -x

#databasepass=`cat /root/passwords/databasepass.txt`

mkdir /mnt/sync
mkdir /mnt/sync/backups/mailserver

DATE=`date +%F`
FILENAME=mailserver-$DATE.tar.gz
SRCDIR=/opt/DockerSwarmData
DESTDIR=/mnt/sync/backups/mailserver
tar --gzip -cf "$DESTDIR/$FILENAME" -C $SRCDIR mailserver

## Delete older backups
ls -t $DESTDIR/mailserver-*.tar.gz | tail -n +10 | xargs rm --
