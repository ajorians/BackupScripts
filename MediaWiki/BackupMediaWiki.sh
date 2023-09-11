#!/bin/bash

databasepass=`cat /root/passwords/databasepass.txt`

mkdir /mnt/backups
mkdir /mnt/backups/mediawiki

DATE=`date +%F`
FILENAME=mediawiki-$DATE.tar.gz
SRCDIR=/srv/www/htdocs/mediawiki-1.39.3
DESTDIR=/mnt/backups/mediawiki
tar --gzip -cf "$DESTDIR/$FILENAME" $SRCDIR

FILENAMEDB=mediawikidb-$DATE.tar.gz

mysqldump -u root -p$databasepass mediawiki > "$DESTDIR/$FILENAMEDB"

## Delete older backups
find "$DESTDIR/$FILENAME" -type f -mtime +10 -delete
find "$DESTDIR/$FILENAMEDB" -type f -mtime +10 -delete
