# 1. Init kubeadmin

kubeadm init --apiserver-advertise-address 10.0.129.11 --cri-socket unix:///run/containerd/containerd.sock --pod-network-cidr=172.16.0.0/20 --control-plane-endpoint=10.0.129.200:8443 -v=5 --kubernetes-version=1.23.17

kubectl label node k8s-prod01-master01 node-role.kubernetes.io/master=master
kubectl label node k8s-prod01-master02 node-role.kubernetes.io/master=master
kubectl label node k8s-prod01-master03 node-role.kubernetes.io/master=master

kubectl label node k8s-prod01-worker01 node-role.kubernetes.io/worker=worker
kubectl label node k8s-prod01-worker02 node-role.kubernetes.io/worker=worker
kubectl label node k8s-prod01-worker03 node-role.kubernetes.io/worker=worker
kubectl label node k8s-prod01-worker04 node-role.kubernetes.io/worker=worker

kubectl label node k8s-prod01-worker01 worker01=worker01
kubectl label node k8s-prod01-worker02 worker02=worker02
kubectl label node k8s-prod01-worker03 worker03=worker03
kubectl label node k8s-prod01-worker04 worker04=worker04

kubectl label node k8s-prod01-worker01 enable-longhorn-storage=true
kubectl label node k8s-prod01-worker02 enable-longhorn-storage=true
kubectl label node k8s-prod01-worker03 enable-longhorn-storage=true
kubectl label node k8s-prod01-worker04 enable-longhorn-storage=true


lsmod | grep br_netfilter
sudo systemctl enable kubelet

# 2. Get kubectl config

mkdir -p $HOME/.kube
sudo cp -f /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# 3. Update node INTERNAL-IP

# add option --node-ip=10.104.0.2 to file
nano /var/lib/kubelet/kubeadm-flags.env
systemctl restart kubelet

## JOIN WORKER NODE

# Print join command, and run on cluster worker
kubeadm token create --print-join-command
kubeadm init phase upload-certs --upload-certs

# output
kubeadm join 10.0.129.200:8443 --token 5izpb4.0ofvnfvu9a1n0uyi --discovery-token-ca-cert-hash sha256:738b9c7e15d0ad0fda55e9e90b35022049c8d5b77f935c1fb5849375dc1f7453 \
    --apiserver-advertise-address 10.0.129.13 \
    --control-plane --certificate-key 49fcc674492f0fb85a80f2a6457de1794464506d9b4cc23ab5163b78e7e9b259

systemctl stop apparmor
systemctl disable apparmor
systemctl restart containerd.service

# update multipath to ignore PVC of longhorn. update on all worker and master 
nano /etc/multipath.conf
```
defaults {
    user_friendly_names yes
}
blacklist {
    devnode "^sd[a-z0-9]+"
}
```
systemctl restart multipathd.service
