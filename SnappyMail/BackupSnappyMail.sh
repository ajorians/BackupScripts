#!/bin/bash -x

#databasepass=`cat /root/passwords/databasepass.txt`

mkdir /mnt/backups
mkdir /mnt/backups/sync/snappymail

DATE=`date +%F`
FILENAME=snappymail-$DATE.tar.gz
SRCDIR=/srv/www/htdocs
DESTDIR=/mnt/backups/sync/snappymail
tar --gzip -cf "$DESTDIR/$FILENAME" -C $SRCDIR snappymail

## Delete older backups
ls -t $DESTDIR/snappymail-*.tar.gz | tail -n +10 | xargs rm --
