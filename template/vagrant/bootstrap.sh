#!/bin/bash

HOST_OS=$1
shift

# Space for global provisioning procedures

# For user specific provision use usr/bootstrap.sh
if [ -f /vagrant-usr/bootstrap.sh ]; then
	. /vagrant-usr/bootstrap.sh
	echo "-I|Source user configuration bootstrap finished!"
fi

echo "-I|Provision finished!"