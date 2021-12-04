#!/bin/sh

# copy.sh

# Copy script to a local VM to test

# On Arch you need to set a root password with `passwd`

# On Artix sshd is not started by default
# openrc: rc-service sshd start

set -x

if [ "${1}" = arch ]; then
	user="root"
	dir="/root"
else
	user="artix"
	dir="/home/${user}"
fi

scp -P 2222 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null \
	IUseArchBTW "${user}"@127.0.0.1:"${dir}"
