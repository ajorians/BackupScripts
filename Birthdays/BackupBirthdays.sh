#!/bin/bash -x

databasepass=`cat /root/passwords/databasepass.txt`

mkdir /mnt/
mkdir /mnt/sync/backups/birthdays

DATE=`date +%F`
FILENAME=birthdays-$DATE.tar.gz
SRCDIR=/srv/www/htdocs
DESTDIR=/mnt/sync/backups/birthdays
tar --gzip -cf "$DESTDIR/$FILENAME" -C $SRCDIR birthdays

FILENAMEDB=birthdaysdb-$DATE.sql

mysqldump -u root -p$databasepass birthdays > "$DESTDIR/$FILENAMEDB"

## Delete older backups
ls -t $DESTDIR/birthdays-*.tar.gz | tail -n +10 | xargs rm --
ls -t $DESTDIR/birthdaysdb-*.sql | tail -n +10 | xargs rm --

