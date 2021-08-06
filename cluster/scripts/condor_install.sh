#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo ">> INSTALLING HTC CONDOR ..."

wget -O /etc/yum.repos.d/RPM-GPG-KEY-HTCondor https://research.cs.wisc.edu/htcondor/yum/RPM-GPG-KEY-HTCondor

rpm --import /etc/yum.repos.d/RPM-GPG-KEY-HTCondor

wget -O /etc/yum.repos.d/htcondor-development-rhel7.repo https://research.cs.wisc.edu/htcondor/yum/repo.d/htcondor-stable-rhel7.repo

yum install -y epel-release condor-all

systemctl enable condor

# systemctl start condor
