#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

VIRTUALBOX_VERSION=$1

echo ">> INSTALLING VIRTUALBOX GUEST ADDITIONS (${VIRTUALBOX_VERSION}) ..."

if [[ $(lsmod | grep -i vbox | wc -l) -ne 0 ]]
  then echo "*** Virtualbox guest additions already installed.  Skipping."
  exit
fi

yum install -y gcc make perl kernel-headers kernel-devel

wget http://download.virtualbox.org/virtualbox/${VIRTUALBOX_VERSION}/VBoxGuestAdditions_${VIRTUALBOX_VERSION}.iso

mkdir -p /media/VBoxGuestAdditions

mount -o loop,ro VBoxGuestAdditions_${VIRTUALBOX_VERSION}.iso /media/VBoxGuestAdditions

sh /media/VBoxGuestAdditions/VBoxLinuxAdditions.run

/sbin/rcvboxadd quicksetup all

rm VBoxGuestAdditions_${VIRTUALBOX_VERSION}.iso

umount /media/VBoxGuestAdditions

rmdir /media/VBoxGuestAdditions
