#!/bin/bash
echo "'run this as a sudo or root user 'sudo bash rke2ks.sh'"
echo 'getting the latest kubectl binary'
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
mv kubectl /usr/bin/kubectl
echo 'got it'
echo 'getting rke2 binary'
mkdir -p /etc/rancher/rke2
echo 'write-kubeconfig-mode: "0644"' >> /etc/rancher/rke2/config.yaml
echo 'disable: rke2-ingress-nginx' >> /etc/rancher/rke2/config.yaml
curl -sfL https://get.rke2.io | INSTALL_RKE2_VERSION=v1.21.14+rke2r1 sh -
systemctl enable rke2-server.service
systemctl start rke2-server.service
echo 'waiting for 11 seconds'
sleep 10s
sed -zi '/export KUBECONFIG=/etc/rancher/rke2/rke2.yaml/!s/$/\nexport KUBECONFIG=/etc/rancher/rke2/rke2.yaml/' ~/.bashrc
sed -zi '/export PATH=$PATH:/var/lib/rancher/rke2/bin/!s/$/\nexport PATH=$PATH:/var/lib/rancher/rke2/bin/' ~/.bashrc
sed -zi '/export PATH=$PATH:/usr/bin/kubectl/!s/$/\nexport PATH=$PATH:/usr/bin/kubectl/' ~/.bashrc
chmod 777 /etc/rancher/rke2/rke2.yaml
chmod 777 /usr/bin/kubectl
chmod +x /usr/bin/kubectl
export KUBECONFIG=/etc/rancher/rke2/rke2.yaml PATH=$PATH:/var/lib/rancher/rke2/bin PATH=$PATH:/usr/bin/kubectl
source ~/.bashrc