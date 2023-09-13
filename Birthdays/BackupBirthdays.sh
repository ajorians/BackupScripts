#!/bin/bash -x

databasepass=`cat /root/passwords/databasepass.txt`

mkdir /mnt/backups
mkdir /mnt/backups/birthdays

DATE=`date +%F`
FILENAME=birthdays-$DATE.tar.gz
SRCDIR=/srv/www/htdocs
DESTDIR=/mnt/backups/birthdays
tar --gzip -cf "$DESTDIR/$FILENAME" -C $SRCDIR birthdays

FILENAMEDB=birthdaysdb-$DATE.sql

mysqldump -u root -p$databasepass birthdays > "$DESTDIR/$FILENAMEDB"

## Delete older backups
find "$DESTDIR/$FILENAME" -type f -mtime +10 -delete
find "$DESTDIR/$FILENAMEDB" -type f -mtime +10 -delete
