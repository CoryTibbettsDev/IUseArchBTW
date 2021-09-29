#!/bin/sh

# Copy script to local VM to test

set -x

if [ "${1}" = "arch" ]; then
	scp -P 2222 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null IUseArchBTW root@127.0.0.1:/root
else
	scp -P 2222 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null IUseArchBTW artix@127.0.0.1:/home/artix
fi
