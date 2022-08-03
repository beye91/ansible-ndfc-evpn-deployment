#!/usr/bin/env bash

while read serialNumber
do 
    publicKey=`jq '.[] | select(.serialNumber == "'$serialNumber'") | {publicKey} ' /tmp/ansible_create_fabric/get_devices.output | grep publicKey | awk -F '"' '{print $4}'`
    echo $publicKey
    fingerprint=`jq '.[] | select(.serialNumber == "'$serialNumber'") | {fingerprint} ' /tmp/ansible_create_fabric/get_devices.output | grep fingerprint | awk -F '"' '{print $4}'`
    echo $fingerprint
    sed -e "s/publicKey_${serialNumber}/${publicKey}/" inventory.json
    sed -e "s/fingerprint_${serialNumber}/${fingerprint}/" inventory.json
done < <(cat inventory.json | grep serialNumber | awk -F ':' '{print $2}')