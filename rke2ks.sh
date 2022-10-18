#!/bin/bash
echo "'run this as a sudo or root user 'sudo bash rke2ks.sh'"
echo 'getting the latest kubectl binary'
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
echo 'got it'
echo 'getting rke2 binary'
curl -sfL https://get.rke2.io | sh -
systemctl enable rke2-server.service
systemctl start rke2-server.service
echo 'waiting for 11 seconds'
sleep 10s
echo "KUBECONFIG=/etc/rancher/rke2/rke2.yaml" >> ~/.bashrc
echo "PATH=$PATH:/var/lib/rancher/rke2/bin" >> ~/.bashrc
export KUBECONFIG=/etc/rancher/rke2/rke2.yaml PATH=$PATH:/var/lib/rancher/rke2/bin
source ~/.bashrc