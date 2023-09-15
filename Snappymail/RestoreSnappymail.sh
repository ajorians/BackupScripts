#!/bin/bash

databasepass=`cat /root/passwords/databasepass.txt`

echo "Enter full path to Snappymail files backup:"
read snappymailbackup

if [ ! -f "$snappymailbackup" ]; then
    echo "$snappymailbackup does not exist."
    exit 1
fi

tar -xvf $snappymailbackup -C /srv/www/htdocs

