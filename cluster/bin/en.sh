#!/bin/sh

NAME=en

VAGRANT_VAGRANTFILE=vagrantfiles/$NAME.vagrantfile VAGRANT_DOTFILE_PATH=vagrantfiles/.vagrant_$NAME vagrant $1 $2 $3 $4 $5
