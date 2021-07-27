#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo ">> CONFIGURING EXECUTE ROL ..."

sh -c 'echo "use ROLE: Execute" > /etc/condor/config.d/51-role-exec'