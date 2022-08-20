# !/usr/bin/env bash

set -e

# $1: MAAS_DBUSER
# $2: MAAS_DBPASS
# $3: MAAS_DBNAME

echo "Setting up PostgreSQL..."

# Create a PostgreSQL user if it does not already exist
if [ -z $(sudo -u postgres psql postgres --tuples-only --no-align \
            -c "SELECT 1 FROM pg_roles WHERE rolname='${1}'") ] 
then
    sudo -u postgres \
        psql -c "CREATE USER \"${1}\" WITH ENCRYPTED PASSWORD '${2}'"
fi

# Create the MAAS database if it does not already exist
if ! sudo -u postgres psql -lqt | cut -d \| -f 1 | grep -qw ${3}
then
    sudo -u postgres createdb -O "${1}" "${3}"
fi


# Edit /etc/postgresql/10/main/pg_hba.conf and add a line for the newly
# created database, replacing the variables with actual names
if ! grep -qw "host    ${3}    ${1}    0/0     md5" \
        /etc/postgresql/12/main/pg_hba.conf
then
    tee -a /etc/postgresql/12/main/pg_hba.conf << EOF
host    ${3}    ${1}    0/0     md5
EOF
fi
