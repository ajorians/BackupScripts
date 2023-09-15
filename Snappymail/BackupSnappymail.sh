#!/bin/bash -x

databasepass=`cat /root/passwords/databasepass.txt`

mkdir /mnt/backups
mkdir /mnt/backups/snappymail

DATE=`date +%F`
FILENAME=snappymail-$DATE.tar.gz
SRCDIR=/srv/www/htdocs
DESTDIR=/mnt/backups/snappymail
tar --gzip -cf "$DESTDIR/$FILENAME" -C $SRCDIR snappymail

## Delete older backups
find "$DESTDIR/$FILENAME" -type f -mtime +10 -delete
