#!/usr/bin/env bash

set -e

# $1: MAAS_IP
# $2: OAM_DYNAMIC_RANGE_START
# $3: OAM_DYNAMIC_RANGE_END
# $4: OAM_RESERVED_RANGE_START
# $5: OAM_RESERVED_RANGE_END
# $6: HOST_USERNAME
# $7: HOST_IP
# $8: OAM_NETWORK_PREFIX
# $9: CLOUD_NODES_COUNT
# $10: LOCAL_IMAGE_MIRROR_URL
# $11: MAAS_DBUSER
# $12: MAAS_DBPASS
# $13: MAAS_DBNAME
# $14: NODE_SSH_USER
# $15: NODE_SOURCE_SSH_KEYFILE_PUB


# Initialize MAAS
echo "Initializing MAAS..."
if ! (maas apikey --username root > /dev/null 2>&1)
then
    maas init region+rack \
        --maas-url http://localhost:5240/MAAS/ \
        --database-uri "postgres://${11}:${12}@localhost/${13}"
    maas createadmin --username root --password root --email root@localhost.localdomain
else
    echo "MAAS already initialized, skipping"
fi

# Wait until MAAS endpoint URL is available
while nc -z localhost 5240 ; [ $? -ne 0 ] 
do
    echo "MAAS endpoint URL is not available yet, waiting 10s..."
    sleep 10
done

# Log into MAAS
echo "Logging into MAAS..."
maas login root http://localhost:5240/MAAS $(maas apikey --username root)

# Use local image mirror, if configured
if [ ! -z ${10} ]
then
    echo "Requesting MAAS to stop importing images before updating" \
         "boot-source with local image mirror URL..."
    maas root boot-resources stop-import

    while [ $(maas root boot-resources is-importing) != "false" ]
    do 
        echo "MAAS is still importing images. Requesting MAAS to stop" \
             "importing images (again) and waiting 30s..."
        maas root boot-resources stop-import
        sleep 30
    done
    
    echo "Updating boot-source to point to local image mirror..."
    maas root boot-source update 1 url="${10}"
fi

# Add Ubuntu 18.04 Bionic Beaver to boot sources if not already added
if [ -z $(maas root boot-source-selections read 1 | \
            jq '.[] | select(."release" == "bionic") | ."id"') ]
then
    maas root boot-source-selections create 1 \
        os="ubuntu" release="bionic" arches="amd64" \
        subarches="*" labels="*"
fi

# Start importing images
echo "Requesting MAAS to import images..."
maas root boot-resources import

# Import local SSH key to MAAS, if not already imported
echo "Importing SSH key..."
if ! (maas root sshkeys read | grep "$(</home/${14}/${15})")
then
    maas root sshkeys create "key=$(</home/${14}/${15})"
else
    echo "SSH key already imported, skipping"
fi

# Skip intro
echo "Configuring 'completed_intro'..."
maas root maas set-config name=completed_intro value=true

# Create reserved dynamic range for OAM network (if it does not exist already)
echo "Creating dynamic range..."
RESULT=$(maas root ipranges read | \
    jq ".[] | select((.type==\"dynamic\") and (.start_ip==\"$2\") and (.end_ip==\"$3\")) | .id")
if [ -z ${RESULT} ]
then
    maas root ipranges create type=dynamic start_ip=$2 end_ip=$3
else
    echo "Dynamic range already created, skipping"
fi

# Create reserved range for MAAS server and networking equipment
echo "Creating reserved range..."
RESULT=$(maas root ipranges read | \
    jq ".[] | select((.type==\"reserved\") and (.start_ip==\"$4\") and (.end_ip==\"$5\")) | .id")
if [ -z ${RESULT} ]
then
    maas root ipranges create type=reserved start_ip=$4 end_ip=$5
else
    echo "Reserved range already created, skipping"
fi

# # Provide DHCP for OAM network subnet
# echo "Configuring DHCP for OAM network..."
# maas root vlan update fabric-1 untagged primary_rack=maas dhcp_on=True

# Configure default gateway for OAM network
echo "Configuring gateway for OAM network..."
maas root subnet update ${8}0/24 gateway_ip=${8}1

# Disable 'Automatically sync images'
echo "Disabling 'Automatically sync images'..."
maas root maas set-config name=boot_images_auto_import value=false

# Wait until MAAS finished importing images
echo "Waiting for MAAS to finish importing images..."
while [ $(maas root boot-resources is-importing) != "false" ]
do 
    echo "MAAS is still importing images, waiting 30s..."
    sleep 30
done

# Wait until Rack Controller finishes syncing images
echo "Waiting for Rack Controller to finish synchronizing the images "; 
RACK_CONTROLLER_ID=$(maas root region-controllers read | \
    jq --raw-output '.[] | .system_id')
while [ $(maas root rack-controller list-boot-images $RACK_CONTROLLER_ID | \
    jq --raw-output '.status') != "synced" ]
do 
    echo "MAAS Rack is still synchronizing images, waiting 30s..."
    sleep 30
done