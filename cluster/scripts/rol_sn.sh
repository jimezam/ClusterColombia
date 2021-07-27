#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo ">> CONFIGURING SUBMIT ROL ..."

sh -c 'echo "use ROLE: Submit" > /etc/condor/config.d/51-role-submit'

service condor restart