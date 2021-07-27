#!/bin/bash

condor_base_version="8"
cluster_cm="cm"

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo ">> CONFIGURING GENERAL ROL ..."

sh -c 'echo "CONDOR_HOST = ${1}" > /etc/condor/config.d/49-common' echo $cluster_cm

firewall-cmd --zone=public --add-port=9618/tcp --permanent

firewall-cmd --reload

# Store password authentications between machines

mkdir /etc/condor/passwords.d

chmod 700 /etc/condor/passwords.d

# Copy base security configuration
## TODO: check base configuration

cp /usr/share/doc/condor-${condor_base_version}*/examples/50-security /etc/condor/config.d

# Set connection password between machines

condor_store_cred add -c -p "CanarioAmarillo"

