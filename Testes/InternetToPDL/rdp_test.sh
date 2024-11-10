#!/bin/bash

source ../public_ips.sh

RDP_PORTS=(3389 3390)

for port in "${RDP_PORTS[@]}"; do
    nc -vz $PDL_PUBLIC_IP $port &>/dev/null
    if [ $? -eq 0 ]; then
        echo "RDP port $port is open on $PDL_PUBLIC_IP"
    else
        echo "RDP port $port is closed or filtered on $PDL_PUBLIC_IP"
    fi
done
