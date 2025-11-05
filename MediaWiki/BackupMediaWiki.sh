#!/bin/bash -x

databasepass=`cat /root/passwords/databasepass.txt`

mkdir /mnt/sync/backups
mkdir /mnt/sync/backups/mediawiki

DATE=`date +%F`
DESTDIR=/mnt/sync/backups/mediawiki

FILENAMEDB=mediawikidb-$DATE.sql

mysqldump -u root -p$databasepass mediawiki > "$DESTDIR/$FILENAMEDB"

## Delete older backups
ls -t $DESTDIR/mediawikidb-*.sql | tail -n +10 | xargs rm --
