#!/bin/bash -x

#databasepass=`cat /root/passwords/databasepass.txt`

mkdir /mnt/sync
mkdir /mnt/sync/backups/snappymail

DATE=`date +%F`
FILENAME=snappymail-$DATE.tar.gz
SRCDIR=/srv/www/htdocs
DESTDIR=/mnt/sync/backups/snappymail
tar --gzip -cf "$DESTDIR/$FILENAME" -C $SRCDIR snappymail

## Delete older backups
ls -t $DESTDIR/snappymail-*.tar.gz | tail -n +10 | xargs rm --
