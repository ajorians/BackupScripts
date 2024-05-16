#!/bin/bash

if [ ! -f /root/passwords/databasepass.txt ]; then
    echo "Database file not found!"
    exit 1
fi

databasepass=`cat /root/passwords/databasepass.txt`

ask()
{
  declare -g $1="$2"
  if [ -z "${!1}" ]; then
    echo "$3"
    read $1
  fi
}

ask MEDIAWIKIBACKUP "$1" "Full path to mediawiki backup .tar.gz file:"
ask MEDIAWIKIDBBACKUP "$2" "Full path to mediawiki database backup .sql file:"

if [ ! -f "$MEDIAWIKIBACKUP" ]; then
    echo "$MEDIAWIKIBACKUP does not exist."
    exit 1
fi

if [ ! -f "$MEDIAWIKIDBBACKUP" ]; then
    echo "$MEDIAWIKIDBBACKUP does not exist."
    exit 1
fi

mysql -u root -p$databasepass -e "create database mediawiki"; 
mysql -u root -p$databasepass mediawiki < $MEDIAWIKIDBBACKUP

tar -xvf $MEDIAWIKIBACKUP -C /srv/www/htdocs

sed -i 's/https:\/\/wiki.orians.org/http:\/\/wikibackup.orians.org/g' /srv/www/htdocs/mediawiki-*/LocalSettings.php

