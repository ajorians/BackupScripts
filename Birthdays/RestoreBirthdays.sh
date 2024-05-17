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

ask BIRTHDAYSBACKUP "$1" "Full path to mediawiki backup .tar.gz file:"
ask BIRTHDAYSDBBACKUP "$2" "Full path to mediawiki database backup .sql file:"

if [ ! -f "$BIRTHDAYSBACKUP" ]; then
    echo "$BIRTHDAYSBACKUP does not exist."
    exit 1
fi

if [ ! -f "$BIRTHDAYSDBBACKUP" ]; then
    echo "$BIRTHDAYSDBBACKUP does not exist."
    exit 1
fi

mysql -u root -p$databasepass -e "create database birthdays"; 
mysql -u root -p$databasepass birthdays < $BIRTHDAYSDBBACKUP

tar -xvf $BIRTHDAYSBACKUP -C /srv/www/htdocs

