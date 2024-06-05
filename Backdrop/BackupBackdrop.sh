#!/bin/bash -x

databasepass=`cat /root/passwords/databasepass.txt`

mkdir /mnt/sync/backups
mkdir /mnt/sync/backups/backdrop

DATE=`date +%F`
FILENAME=backdrop-$DATE.tar.gz
SRCDIR=/srv/www/htdocs
DESTDIR=/mnt/sync/backups/backdrop
tar --gzip -cf "$DESTDIR/$FILENAME" -C $SRCDIR backdrop

FILENAMEDB=backdropdb-$DATE.sql

mysqldump -u root -p$databasepass backdrop > "$DESTDIR/$FILENAMEDB"

## Delete older backups
ls -t $DESTDIR/backdrop-*.tar.gz | tail -n +10 | xargs rm --
ls -t $DESTDIR/backdropdb-*.sql | tail -n +10 | xargs rm --

