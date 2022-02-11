#!/bin/sh

# copy.sh

# Copy script to a local VM to test

# On Arch you need to set a root password with `passwd`

# On Artix sshd is not started by default
# openrc: rc-service sshd start

port=2222

while getopts "hp:u:ct" opt; do
	case "${opt}" in
		h)
			printf "%s: Usage: [-p <port>] [-u <user>]\n" "$0"
			exit 0
			;;
		p) port="${OPTARG}";;
		u) user="${OPTARG}";;
		c) os="arch";;
		t) os="artix";;
	esac
done

if [ "${os}" = arch ]; then
	user="root"
	dir="/root"
else
	user="artix"
	dir="/home/${user}"
fi

set -x

scp -P "${port}" -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null \
	IUseArchBTW "${user}"@127.0.0.1:"${dir}"

set +x
