#!/bin/bash

databasepass=`cat /root/passwords/databasepass.txt`

echo "Enter full path to birthdays files backup:"
read birthdaybackup

echo "Enter full path to birthdays database backup:"
read birthdaydbbackup

if [ ! -f "$birthdaybackup" ]; then
    echo "$birthdaybackup does not exist."
    exit 1
fi

if [ ! -f "$birthdaydbbackup" ]; then
    echo "$birthdaydbbackup does not exist."
    exit 1
fi

mysql -u root -p$databasepass -e "create database birthdays"; 
mysql -u root -p$databasepass birthdays < $birthdaydbbackup

tar -xvf $birthdaybackup -C /srv/www/htdocs

