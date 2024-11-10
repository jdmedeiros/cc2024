#!/bin/bash

source ../public_ips.sh

URLS=(
  "http://$ENTA_LB_ADDRESS/info.php"
  "https://$ENTA_LB_ADDRESS/info.php"
)

for url in "${URLS[@]}"; do
    echo "Testing PHP availability at $url..."

    # Check for "PHP Version" in the output, which indicates PHP processing
    response=$(curl -sk $url)
    if echo "$response" | grep -q "PHP Version"; then
        echo "PHP is installed and responding on $url"
    else
        echo "PHP is not responding as expected on $url"
    fi
done
