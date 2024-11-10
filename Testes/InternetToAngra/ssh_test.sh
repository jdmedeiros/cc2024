#!/bin/bash

source ../public_ips.sh

SSH_PORTS=(22 222)

for port in "${SSH_PORTS[@]}"; do
    nc -zv $ANGRA_PUBLIC_IP $port &>/dev/null
    if [ $? -eq 0 ]; then
        echo "Port $port is open on $ANGRA_PUBLIC_IP"
    else
        echo "Port $port is closed or filtered on $ANGRA_PUBLIC_IP"
    fi
done
