#!/usr/bin/env bash

while read serialNumber
do 
    publicKey=`jq '.[] | select(.serialNumber == "'$serialNumber'") | {publicKey} ' /tmp/ansible_create_fabric/get_devices.output | grep publicKey | awk -F '"' '{print $4}'`
    fingerprint=`jq '.[] | select(.serialNumber == "'$serialNumber'") | {fingerprint} ' /tmp/ansible_create_fabric/get_devices.output | grep fingerprint | awk -F '"' '{print $4}'`
    cat inventory.json | sed -e "s/publicKey_${serialNumber}/${publicKey}/" 
    cat inventory.json | sed -e "s/fingerprint_${serialNumber}/${fingerprint}/"
done < <(cat inventory.json | grep serialNumber | awk -F ':' '{print $2}')