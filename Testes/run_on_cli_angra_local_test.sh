#!/bin/bash

# Define expected hostname and script name
EXPECTED_HOSTNAME="cli.angra.local"

# Check hostname
CURRENT_HOSTNAME=$(hostnamectl | grep "Static hostname" | awk '{print $3}')

if [ "$CURRENT_HOSTNAME" != "$EXPECTED_HOSTNAME" ]; then
    echo "This is not the expected host ($EXPECTED_HOSTNAME). Exiting..."
    exit 1
fi

echo "Confirmed: Hostname is $EXPECTED_HOSTNAME"; echo

# Check if script is running
if pgrep -f "$SCRIPT_NAME" > /dev/null; then
    echo "Script $SCRIPT_NAME is running."
else
    echo "Script $SCRIPT_NAME is NOT running."
    exit 1
fi



# Source the public IPs and other configuration variables
source ./public_ips.sh

# Define URLs to test
URLS=(
  "http://${ENTA_LB_ADDRESS}"
  "http://${ENTA_LB_ADDRESS}/info.php"
  "https://${ENTA_LB_ADDRESS}"
  "https://${ENTA_LB_ADDRESS}/info.php"
  "http://intranet.angra.local"
  "http://intranet.angra.local/info.php"
  "https://intranet.angra.local"
  "https://intranet.angra.local/info.php"
  "http://www.eppv.pt"
  "http://www.eppv.pt/info.php"
  "https://www.eppv.pt"
  "https://www.eppv.pt/info.php"
)

# Test HTTP/HTTPS URLs
echo "Testing HTTP/HTTPS URLs..."
for url in "${URLS[@]}"; do
    echo "Testing $url..."; echo ""
    if [[ "$url" == https* ]]; then
        curl -sIk $url | grep -E 'Server|X-Backend-Server|X-Served-By|X-Powered-By' || echo "No server identifier found in headers for $url"
    else
        curl -sI $url | grep -E 'Server|X-Backend-Server|X-Served-By|X-Powered-By' || echo "No server identifier found in headers for $url"
    fi
    read -rsn1 -p "Ready? - press any key to continue"; echo
done
read -rsn1 -p "Ready? - press any key to continue"; echo

echo -e "\nHTTP/HTTPS URL tests complete.\n"

# MySQL Workbench Connection (Simulated)
echo "Simulating MySQL Workbench connection to RDS and Northwind database..."
# Replace with actual command if connection check is needed
echo "MySQL Workbench connection simulation complete."
read -rsn1 -p "Ready? - press any key to continue"; echo

# Define IPs to ping (positive and negative tests)
PING_IPS=(
  "8.8.8.8"
  "172.16.0.100"
  "172.16.144.100"
  "172.16.144.101"
)

NO_PING_IPS=(
  "10.0.0.100"
  "10.0.9.100"
  "10.0.9.102"
  "10.0.8.100"
  "10.0.9.101"
)

# Ping IPs that should respond
echo -e "\nPinging IPs expected to respond..."
for ip in "${PING_IPS[@]}"; do
    if ping -c 2 $ip &>/dev/null; then
        echo "Ping to $ip successful."
    else
        echo "Ping to $ip failed."
    fi
done
read -rsn1 -p "Ready? - press any key to continue"; echo

# Ping IPs that should NOT respond
echo -e "\nPinging IPs expected NOT to respond..."
for ip in "${NO_PING_IPS[@]}"; do
    if ping -c 2 $ip &>/dev/null; then
        echo "Ping to $ip unexpectedly succeeded."
    else
        echo "Ping to $ip failed as expected."
    fi
done

echo -e "\nAll tests completed."
