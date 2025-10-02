#!/bin/bash -x

databasepass=`cat /root/passwords/databasepass.txt`

mkdir /mnt/sync/backups
mkdir /mnt/sync/backups/mediawiki

DATE=`date +%F`
FILENAME=mediawiki-$DATE.tar.gz
SRCDIR=/srv/www/htdocs
DESTDIR=/mnt/sync/backups/mediawiki
tar --gzip -cf "$DESTDIR/$FILENAME" -C $SRCDIR mediawiki-1.44.0

FILENAMEDB=mediawikidb-$DATE.sql

mysqldump -u root -p$databasepass mediawiki > "$DESTDIR/$FILENAMEDB"

## Delete older backups
ls -t $DESTDIR/mediawiki-*.tar.gz | tail -n +10 | xargs rm --
ls -t $DESTDIR/mediawikidb-*.sql | tail -n +10 | xargs rm --
