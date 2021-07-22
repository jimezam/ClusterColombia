#!/bin/sh

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo ">> UPGRADING PACKAGES ..."

yum -y update

yum -y upgrade

yum clean all
