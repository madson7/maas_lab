#!/usr/bin/env bash
set -e

# $1: NODE_SSH_USER
# $2: MAAS_IP

# Log into MAAS
echo "Logging into MAAS..."
maas login root http://localhost:5240/MAAS $(maas apikey --username root)

# Conexão de host KVM
maas root vm-hosts create type="virsh" power_address="qemu+ssh://${1}@${2}/system" power_pass="*(Infra@sea89" name="controller_maas"

# virt-install --name node-1 \
#     --virt-type kvm --memory 2096 --vcpus 2 \
#     --disk size=15,device=disk \
#     --os-type linux --os-variant generic \
#     --network network=OAM\
#     --graphics none \
#     --import