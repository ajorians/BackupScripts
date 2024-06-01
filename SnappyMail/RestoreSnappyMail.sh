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

ask SNAPPYMAILBACKUP "$1" "Full path to SnappyMail backup .tar.gz file:"

if [ ! -f "$SNAPPYMAILBACKUP" ]; then
    echo "$SNAPPYMAILBACKUP does not exist."
    exit 1
fi

tar -xvf $SNAPPYMAILBACKUP -C /srv/www/htdocs

