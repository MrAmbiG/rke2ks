# rke2single
* bootstrap a single node k8s cluster via rke2 *
- sudo bash rke2ks.sh

## Add more worker nodes
- write config.yaml as following <br>
`
token: K101ad4d209b9d453c2de43a7aed07ca8cbf4b6effa4c13cfedc1c7b054c4c4729a::server:e20bdc7a1789d576a1334fee0d65df6b # /var/lib/rancher/rke2/server/token from master1 <br>
server: https://?master-nod-ip?:9345
`
- sudo su -
- cd /home/?useraccount?> # user account is usually k8sprod or master, wherever you have copied the config.yaml
- mkdir -p /etc/rancher/rke2/
- cp config.yaml /etc/rancher/rke2/config.yaml # their respective config.yaml
- cp registries.yaml /etc/rancher/rke2/ # copy registry file
- curl -sfL https://get.rke2.io | INSTALL_RKE2_TYPE="agent" INSTALL_RKE2_VERSION=v1.21.14+rke2r1 sh -
- systemctl enable rke2-agent.service
- systemctl start rke2-agent.service
* repeat the same for every new worker node *
