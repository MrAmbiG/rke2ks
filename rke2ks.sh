#!/bin/bash
echo "'run this as a sudo or root user 'sudo bash rke2ks.sh'"
echo 'getting the latest kubectl binary'
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
mv kubectl /usr/bin/kubectl
echo 'got it'
echo 'getting rke2 binary'
curl -sfL https://get.rke2.io | sh -
echo 'write-kubeconfig-mode: "0644"' >> /etc/rancher/rke2/rke2.yaml
echo 'disable: rke2-ingress-nginx' >> /etc/rancher/rke2/rke2.yaml
systemctl enable rke2-server.service
systemctl start rke2-server.service
echo 'waiting for 11 seconds'
sleep 10s
echo "export KUBECONFIG=/etc/rancher/rke2/rke2.yaml" >> ~/.bashrc
echo "export PATH=$PATH:/var/lib/rancher/rke2/bin" >> ~/.bashrc
echo "export PATH=$PATH:/usr/bin/kubectl" >> ~/.bashrc
chmod 777 /etc/rancher/rke2/rke2.yaml
chmod 777 /usr/bin/kubectl
chmod +x /usr/bin/kubectl
export KUBECONFIG=/etc/rancher/rke2/rke2.yaml PATH=$PATH:/var/lib/rancher/rke2/bin PATH=$PATH:/usr/bin/kubectl
source ~/.bashrc