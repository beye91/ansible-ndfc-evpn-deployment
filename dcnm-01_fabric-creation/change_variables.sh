#!/usr/bin/env bash

while read serialNumber
do 
    publicKey=${jq '.[] | select(.serialNumber == "'$serialNumber'") | {publicKey} ' /tmp/ansible_create_fabric/get_devices.output | grep publicKey | awk -F '"' '{print $2}'}
    fingerprint=${jq '.[] | select(.serialNumber == "'$serialNumber'") | {fingerprint} ' /tmp/ansible_create_fabric/get_devices.output | grep fingerprint | awk -F '"' '{print $2}'}
    sed -i 's/publicKey_'${serialNumber}'/'${publicKey}'/g' inventory.json
    sed -i 's/fingerprint_'${serialNumber}'/'${fingerprint}'/g' inventory.json
done < <(cat inventory.json | grep serialNumber | awk -F ':' '{print $2}')