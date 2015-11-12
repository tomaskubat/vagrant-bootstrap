#!/bin/bash

# copy user ssh public key to key
if [ -d /vagrant-usr/.ssh/ ]; then
	cp -rf /vagrant-usr/.ssh /root/
	chmod -R go-rwx /root/.ssh
	echo "-I|Copy usr .ssh directory from usr/.ssh finished!"
fi

if [ -f /vagrant-usr/.gitconfig ]
then
    ln -sf /vagrant-usr/.gitconfig /root/.gitconfig
fi
