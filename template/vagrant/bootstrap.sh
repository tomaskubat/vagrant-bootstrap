#!/bin/bash

HOST_OS=$1
shift

# Space for global provisioning procedures

# For user specific provision use usr/bootstrap.sh
if [ -f /vagrant-usr/bootstrap.sh ]; then
	. /vagrant-usr/bootstrap.sh
	echo "-I|Provision usr/bootstrap.sh finished!"
fi

echo "-I|Provision finished!"
