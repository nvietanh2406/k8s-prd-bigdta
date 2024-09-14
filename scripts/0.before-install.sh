# 1. Update OS

sudo apt update -y && sudo apt-get update -y
sudo apt -y install curl make apt-transport-https vim git wget gnupg2 software-properties-common ca-certificates net-tools

# 2. Install kubeadm kubelet kubectl haproxy keepalived

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt -y update
sudo apt -y install kubelet=1.23.17-00 kubeadm=1.23.17-00 kubectl=1.23.17-00
# sudo apt -y install haproxy keepalived
sudo apt-mark hold kubelet=1.23.17-00 kubeadm=1.23.17-00 kubectl=1.23.17-00

# 3. Install containerd as container runtime

sudo tee /etc/modules-load.d/containerd.conf <<EOF
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt update
sudo apt install -y containerd.io

# 4. Enable network forward

sudo tee /etc/sysctl.d/kubernetes.conf <<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
net.ipv4.ip_nonlocal_bind=1
EOF

# 5. Config containerd

## Manually run if not show on output

sudo sysctl --system

mkdir -p /etc/containerd
sudo containerd config default | sudo tee /etc/containerd/config.toml

sudo systemctl restart containerd
sudo systemctl enable containerd

echo DONE
