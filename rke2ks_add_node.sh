#!/bin/bash
# Copy this script to the node, replace MASTER1 witht he ip or domain name of the master1 (controller) of the k8s
# replace MASTER_TOKEN with master token from /var/lib/rancher/rke2/server/token from master1
sudo mkdir -p /etc/rancher/rke2/
rm -rf /etc/rancher/rke2/config.yaml
echo "server: https://MASTER1:9345" > /etc/rancher/rke2/config.yaml
echo "token: MASTER_TOKEN" >> /etc/rancher/rke2/config.yaml
curl -sfL https://get.rke2.io | INSTALL_RKE2_TYPE="agent" INSTALL_RKE2_VERSION=v1.21.14+rke2r1 sudo sh -
sudo systemctl enable rke2-agent.service
sudo systemctl start rke2-agent.service