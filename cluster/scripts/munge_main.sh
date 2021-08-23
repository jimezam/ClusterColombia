#!/usr/bin/bash

# https://github.com/dun/munge/wiki/Installation-Guide

# Install munge base for all nodes

sudo yum -y install epel-release openssl-devel bzip2-devel zlib-devel rpm-build gcc

# Set the latest version accoding to:
# https://github.com/dun/munge/releases/latest

cd /tmp

sudo wget https://github.com/dun.gpg

sudo wget https://github.com/dun/munge/releases/download/munge-0.5.14/munge-0.5.14.tar.xz

sudo wget https://github.com/dun/munge/releases/download/munge-0.5.14/munge-0.5.14.tar.xz.asc

sudo rpmbuild -tb munge-0.5.14.tar.xz

RPMS_PATH=/root/rpmbuild/RPMS/x86_64

sudo rpm -ivh $RPMS_PATH/munge-0.5.14-1.el7.x86_64.rpm \
    $RPMS_PATH/munge-devel-0.5.14-1.el7.x86_64.rpm \
    $RPMS_PATH/munge-libs-0.5.14-1.el7.x86_64.rpm

sudo -u munge mungekey --verbose

# mungekey: Info: Created "/etc/munge/munge.key" with 1024-bit key

# opciones de configuración: /etc/sysconfig/munge

sudo systemctl enable munge

sudo systemctl start munge

# Copy .rpm binary files + key to host



# Remove Munge source distribution files

rm dun.gpg

rm munge-0.5.14.tar.xz

rm munge-0.5.14.tar.xz.asc