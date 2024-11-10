#!/bin/bash

source ../public_ips.sh

echo "Starting RDP tests..."
./rdp_test.sh

read -rsn1 -p"Ready? - press any key to continue";echo

echo -e "\nStarting SSH tests..."
./ssh_test.sh

read -rsn1 -p"Ready? - press any key to continue";echo

echo -e "\nStarting HTTP/HTTPS tests..."
./http_https_test.sh

read -rsn1 -p"Ready? - press any key to continue";echo;echo

./lb_test.sh

read -rsn1 -p"Ready? - press any key to continue";echo;echo

./php_test.sh