#!/usr/bin/env bash

set -e

# $1: NODE_SSH_USER

# Update juju client configuration files
echo "Updating juju client configuration files..."
MAAS_APIKEY=$(maas apikey --username root)
sed -i 's/{{ maas_root_apikey }}/'${MAAS_APIKEY}'/g' /home/${1}/.local/share/juju/credentials.yaml

# juju bootstrap maas-cloud --constraints "cpu-power=8 cpu-cores=8 mem=6144"

