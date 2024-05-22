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

ask BACKDROPBACKUP "$1" "Full path to Backdrop backup .tar.gz file:"
ask BACKDROPDBBACKUP "$2" "Full path to Backdrop database backup .sql file:"

if [ ! -f "$BACKDROPBACKUP" ]; then
    echo "$BACKDROPBACKUP does not exist."
    exit 1
fi

if [ ! -f "$BACKDROPDBBACKUP" ]; then
    echo "$BACKDROPDBBACKUP does not exist."
    exit 1
fi

mysql -u root -p$databasepass -e "create database backdrop"; 
mysql -u root -p$databasepass backdrop < $BACKDROPDBBACKUP

tar -xvf $BACKDROPBACKUP -C /srv/www/htdocs

