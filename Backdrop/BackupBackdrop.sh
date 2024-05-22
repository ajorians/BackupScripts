#!/bin/bash -x

databasepass=`cat /root/passwords/databasepass.txt`

mkdir /mnt/backups
mkdir /mnt/backups/sync/backdrop

DATE=`date +%F`
FILENAME=backdrop-$DATE.tar.gz
SRCDIR=/srv/www/htdocs
DESTDIR=/mnt/backups/sync/backdrop
tar --gzip -cf "$DESTDIR/$FILENAME" -C $SRCDIR backdrop

FILENAMEDB=backdropdb-$DATE.sql

mysqldump -u root -p$databasepass backdrop > "$DESTDIR/$FILENAMEDB"

## Delete older backups
find "$DESTDIR/$FILENAME" -type f -mtime +10 -delete
find "$DESTDIR/$FILENAMEDB" -type f -mtime +10 -delete
