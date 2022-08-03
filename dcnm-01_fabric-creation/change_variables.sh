#!/usr/bin/env bash
set -x
while read serialNumber
do 
    publicKey=`jq '.[] | select(.serialNumber == "'$serialNumber'") | {publicKey} ' /tmp/ansible_create_fabric/get_devices.output | grep publicKey | awk -F '"' '{print $4}'`
    echo $publicKey
    fingerprint=`jq '.[] | select(.serialNumber == "'$serialNumber'") | {fingerprint} ' /tmp/ansible_create_fabric/get_devices.output | grep fingerprint | awk -F '"' '{print $4}'`
    echo $fingerprint
    sed -i -e "s%publicKey_${serialNumber}%${publicKey}%" inventory.yaml
    sed -i -e "s/fingerprint_${serialNumber}/${fingerprint}/" inventory.yaml

done < <(cat inventory.json | grep serialNumber | awk -F ':' '{print $2}')