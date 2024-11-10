#!/bin/bash

source ../public_ips.sh

URLS=(
  "http://$ENTA_LB_ADDRESS"
  "https://$ENTA_LB_ADDRESS"
)

for i in {1..3}; do
    for url in "${URLS[@]}"; do
        echo "Testing $url..."
        if [[ "$url" == https* ]]; then
            curl -sIk $url | grep -E 'Server|X-Backend-Server|X-Served-By|X-Powered-By' || echo "No server identifier found in headers for $url"
        else
            curl -sI $url | grep -E 'Server|X-Backend-Server|X-Served-By|X-Powered-By' || echo "No server identifier found in headers for $url"
        fi
    done
done