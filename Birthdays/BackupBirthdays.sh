#!/bin/bash -x

databasepass=`cat /root/passwords/databasepass.txt`

mkdir /mnt/backups
mkdir /mnt/backups/sync/birthdays

DATE=`date +%F`
FILENAME=birthdays-$DATE.tar.gz
SRCDIR=/srv/www/htdocs
DESTDIR=/mnt/backups/sync/birthdays
tar --gzip -cf "$DESTDIR/$FILENAME" -C $SRCDIR birthdays

FILENAMEDB=birthdaysdb-$DATE.sql

mysqldump -u root -p$databasepass birthdays > "$DESTDIR/$FILENAMEDB"

## Delete older backups
find "$DESTDIR/" -name "birthdaysdb*.sql" -type f -mtime +10 -delete
find "$DESTDIR/" -name "birthdays*.tar.gz" -type f -mtime +10 -delete
