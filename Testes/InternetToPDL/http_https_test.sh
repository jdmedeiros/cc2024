#!/bin/bash

source ../public_ips.sh

URLS=(
  "http://$ENTA_LB_ADDRESS"
  "https://$ENTA_LB_ADDRESS"
)

for url in "${URLS[@]}"; do
    if [[ "$url" == https* ]]; then
        echo "Testing HTTPS for $url..."
        curl -vk $url 2>&1 | grep "subject:" || echo "Failed to access $url"
    elif [[ "$url" == *index.php ]]; then
        echo "Fetching contents of $url..."
        curl -s $url || echo "Failed to fetch content from $url"
    else
        status_code=$(curl -o /dev/null -s -w "%{http_code}" $url)
        if [ "$status_code" -eq 200 ]; then
            echo "Successfully accessed $url - Status Code: $status_code"
        else
            echo "Failed to access $url - Status Code: $status_code"
        fi
    fi
done
