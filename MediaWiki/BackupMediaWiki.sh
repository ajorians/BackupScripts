#!/bin/bash -x

databasepass=`cat /root/passwords/databasepass.txt`

mkdir /mnt/backups
mkdir /mnt/backups/sync/mediawiki

DATE=`date +%F`
FILENAME=mediawiki-$DATE.tar.gz
SRCDIR=/srv/www/htdocs
DESTDIR=/mnt/backups/sync/mediawiki
tar --gzip -cf "$DESTDIR/$FILENAME" -C $SRCDIR mediawiki-1.39.3

FILENAMEDB=mediawikidb-$DATE.sql

mysqldump -u root -p$databasepass mediawiki > "$DESTDIR/$FILENAMEDB"

## Delete older backups
find "$DESTDIR/" -name "mediawiki*.tar.gz" -type f -mtime +10 -delete
find "$DESTDIR/" -name "mediawikidb*.sql" -type f -mtime +10 -delete
