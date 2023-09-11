#!/bin/bash

databasepass=`cat /root/passwords/databasepass.txt`

echo "Enter full path to mediawiki files backup:"
read mediawikibackup

echo "Enter full path to mediawiki database backup:"
read mediawikidbbackup

if [ ! -f "$mediawikibackup" ]; then
    echo "$mediawikibackup does not exist."
    exit 1
fi

if [ ! -f "$mediawikidbbackup" ]; then
    echo "$mediawikidbbackup does not exist."
    exit 1
fi

#mysqldump -u root -p$databasepass < $mediawikidbbackup

#tar -xvf $mediawikibackup -C /srv/www/htdocs

