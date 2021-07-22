#!/bin/sh

NAME=$1

VAGRANT_VAGRANTFILE=vagrantfiles/$NAME.vagrantfile VAGRANT_DOTFILE_PATH=vagrantfiles/.vagrant_$NAME vagrant validate $2 $3 $4 $5
