#!/usr/bin/env bash

set -e

# $1: MAAS_IP

# Log into MAAS
echo "Logging into MAAS..."
maas login root http://localhost:5240/MAAS $(maas apikey --username root)

# Create nodeNN nodes
echo "Creating machines..."

# Check if the machine exists
NODE_NUM=$(printf %02d 1)
MACHINE=$(maas root machines read hostname=node-${NODE_NUM} | jq '.[] | .system_id')

if [ -z ${MACHINE} ]
then
    maas root machines create \
        architecture="amd64/generic" \
        mac_addresses="ac:1f:6b:6a:7f:6a" \
        hostname=node-${NODE_NUM} \
        power_type=ipmi \
        power_parameters_power_driver=LAN_2_0 \
        power_parameters_power_user=ADMIN \
        power_parameters_power_pass=ADMIN \
        power_parameters_power_address="192.168.88.253"
else
    echo "Machine node-${NODE_NUM} already exists, skipping"
fi