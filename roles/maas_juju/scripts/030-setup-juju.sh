#!/usr/bin/env bash

set -e

# $1: MAAS_IP

# Update juju client configuration files
echo "Updating juju client configuration files..."
MAAS_APIKEY=$(maas apikey --username root)
sed -i 's/{{ maas_root_apikey }}/'${MAAS_APIKEY}'/g' /home/vagrant/job/credentials.yaml
sed -i 's/{{ maas_ip }}/'$1'/g' /home/vagrant/job/clouds.yaml

