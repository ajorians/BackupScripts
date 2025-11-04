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

ask MEDIAWIKIDBBACKUP "$1" "Full path to mediawiki database backup .sql file:"

if [ ! -f "$MEDIAWIKIDBBACKUP" ]; then
    echo "$MEDIAWIKIDBBACKUP does not exist."
    exit 1
fi

mysql -u root -p$databasepass -e "create database mediawiki"; 
mysql -u root -p$databasepass mediawiki < $MEDIAWIKIDBBACKUP

sed -i 's/https:\/\/wiki.orians.org/http:\/\/wikibackup.orians.org/g' /opt/DockerSwarmData/mediawiki/LocalSettings.php
sed -i 's/database.orians.org/10.0.0.14/g' /opt/DockerSwarmData/mediawiki/LocalSettings.php

