#!/bin/bash -x

#databasepass=`cat /root/passwords/databasepass.txt`

mkdir /mnt/backups
mkdir /mnt/backups/sync/jellyfin

DATE=`date +%F`
FILENAME=jellyfin-$DATE.tar.gz
SRCDIR=/opt/DockerSwarmData
DESTDIR=/mnt/backups/sync/jellyfin
tar --gzip -cf "$DESTDIR/$FILENAME" -C $SRCDIR jellyfin

## Delete older backups
ls -t $DESTDIR/jellyfin-*.tar.gz | tail -n +10 | xargs rm --
