#!/bin/bash

cluster_cm="cm"

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo ">> CONFIGURING CENTRAL MANAGER ROL ..."

sh -c 'echo "use ROLE: CentralManager" > /etc/condor/config.d/51-role-cm'

## TODO: static hostnames not from config.yaml
sh -c 'echo "ALLOW_WRITE_COLLECTOR=\$(ALLOW_WRITE) en1 en2 sn" >> /etc/condor/config.d/51-role-cm'
