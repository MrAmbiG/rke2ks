#!/bin/bash
echo "'run this as a sudo or root user 'sudo bash addNode.sh'"
if [ ! -f registries.yaml ]; then
    echo "registries.yaml not found!, exiting"
fi
# sudo su - # to ensure it is being run as root or sudo user
sudo mkdir -p /etc/rancher/rke2/
rm -rf config.yaml
echo "get the master token from /var/lib/rancher/rke2/server/token from master1"
read -p "rke2 master token: " token
echo "You entered $token"
read -p "rke2 master domain name or ip address: " master
echo "You entered $master"
echo "server: https://$master:9345" > config.yaml
echo "token: $token" >> config.yaml
cp config.yaml /etc/rancher/rke2/
cp registries.yaml /etc/rancher/rke2/ # copy registry file
curl -sfL https://get.rke2.io | INSTALL_RKE2_TYPE="agent" INSTALL_RKE2_VERSION=v1.21.14+rke2r1 sh -
systemctl enable rke2-agent.service
systemctl start rke2-agent.service