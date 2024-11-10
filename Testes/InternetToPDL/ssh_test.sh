#!/bin/bash

source ../public_ips.sh

SSH_PORTS=(22 222 2222)

for port in "${SSH_PORTS[@]}"; do
    nc -zv $PDL_PUBLIC_IP $port &>/dev/null
    if [ $? -eq 0 ]; then
        echo "Port $port is open on $PDL_PUBLIC_IP"
    else
        echo "Port $port is closed or filtered on $PDL_PUBLIC_IP"
    fi
done
