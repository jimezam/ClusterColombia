#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo ">> ADDING NODES TO /ETC/HOSTS ..."

SOURCE=/vagrant/files/hosts
TARGET=/etc/hosts

# Check if source file exists

if [ ! -f "$SOURCE" ]
then
    echo "ERROR: source file (${SOURCE}) does not exists, create it with 'bin/generate_hosts.rb'."
    exit 1
fi

# Add the nodes hosts info to /etc/hosts

cat $SOURCE > $TARGET

# Checking the result /etc/hosts file

echo "Resultant /etc/hosts file:"

cat $TARGET