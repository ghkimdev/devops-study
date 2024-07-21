#!/bin/bash

# Create cluster
sudo kubeadm init --pod-network-cidr=192.168.0.0/16 > /opt/kubeadm_init.log

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Install Calico
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.28.0/manifests/tigera-operator.yaml
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.28.0/manifests/custom-resources.yaml

kubectl taint nodes --all node-role.kubernetes.io/control-plane-
kubectl get nodes -o wide
