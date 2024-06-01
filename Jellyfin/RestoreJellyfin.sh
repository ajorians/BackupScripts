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

ask JELLYFINBACKUP "$1" "Full path to Jellyfin backup .tar.gz file:"

if [ ! -f "$JELLYFINBACKUP" ]; then
    echo "$JELLYFINBACKUP does not exist."
    exit 1
fi

tar -xvf $JELLYFINBACKUP -C /opt/DockerSwarmData

