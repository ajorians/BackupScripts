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

ask MAILSERVERBACKUP "$1" "Full path to MailServer backup .tar.gz file:"

if [ ! -f "$MAILSERVERBACKUP" ]; then
    echo "$MAILSERVERBACKUP does not exist."
    exit 1
fi

tar -xvf $MAILSERVERBACKUP -C /opt/DockerSwarmData

