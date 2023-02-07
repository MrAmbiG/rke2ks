#!/bin/bash
if [[ "1.23.16" == "$1" ]]; then
    k8s_version="v1.23.16+rke2r1"
    echo "selected k8s version: $k8s_version"
elif [[ "1.24.10" == "$1" ]]; then
    k8s_version="v1.24.10+rke2r1"
    echo "selected k8s version: $k8s_version"
elif [[ "1.25.6" == "$1" ]]; then
    k8s_version="v1.25.6+rke2r1"
    echo "selected k8s version: $k8s_version"
else
   k8s_version="v1.26.1+rke2r1"
   echo "selected k8s version: $k8s_version"
fi
echo "'run this as a sudo or root user 'sudo bash rke2ks.sh'"
echo 'getting the latest kubectl binary'
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
mv kubectl /usr/bin/kubectl
echo 'got it'
echo 'getting rke2 binary'
mkdir -p /etc/rancher/rke2
echo 'write-kubeconfig-mode: "0644"' >> /etc/rancher/rke2/config.yaml
echo 'disable: rke2-ingress-nginx' >> /etc/rancher/rke2/config.yaml
curl -sfL https://get.rke2.io | INSTALL_RKE2_VERSION=$k8s_version sh -
systemctl enable rke2-server.service
systemctl start rke2-server.service
echo 'waiting for 11 seconds'
sleep 10s
sed -i '/KUBECONFIG=/d' ~/.bashrc
echo 'export KUBECONFIG=/etc/rancher/rke2/rke2.yaml' >> ~/.bashrc
chmod 777 /etc/rancher/rke2/rke2.yaml
chmod 777 /usr/bin/kubectl
chmod +x /usr/bin/kubectl
export KUBECONFIG=/etc/rancher/rke2/rke2.yaml PATH=$PATH:/var/lib/rancher/rke2/bin PATH=$PATH:/usr/bin/kubectl
# Installing helm3
echo 'installing helm3'
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
source ~/.bashrc
echo 'Deploying metallb loadbalancer'
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.13.7/config/manifests/metallb-native.yaml
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm upgrade -i ingress-nginx ingress-nginx/ingress-nginx
echo 'create and apply an ip pool for your on prem metallb load balancer as seen on'
echo 'https://metallb.universe.tf/configuration/#defining-the-ips-to-assign-to-the-load-balancer-services'
