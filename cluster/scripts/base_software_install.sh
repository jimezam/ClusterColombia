#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo ">> INSTALLING BASE SOFTWARE ..."

sudo yum install -y wget vim
