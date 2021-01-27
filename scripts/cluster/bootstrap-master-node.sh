#!/bin/bash

sudo kubeadm init --pod-network-cidr=192.168.0.0/16

kubectl create -f https://docs.projectcalico.org/manifests/tigera-operator.yaml --kubeconfig /etc/kubernetes/admin.conf
kubectl create -f https://docs.projectcalico.org/manifests/custom-resources.yaml --kubeconfig /etc/kubernetes/admin.conf

sleep 30

kubectl taint nodes --all node-role.kubernetes.io/master- --kubeconfig /etc/kubernetes/admin.conf

wget https://raw.githubusercontent.com/shashankbarsin/proxy-simulation/main/manifests/simulation.yaml

perl -i -pe "s/<SQUID_NOAUTH_IP>/$(echo -n $SQUID_NOAUTH_IP)/g" simulation.yaml
perl -i -pe "s/<SQUID_BASIC_IP>/$(echo -n $SQUID_BASIC_IP)/g" simulation.yaml
perl -i -pe "s/<SQUID_CERT_IP>/$(echo -n $SQUID_CERT_IP)/g" simulation.yaml

kubectl apply -f simulation.yaml --kubeconfig /etc/kubernetes/admin.conf

mkdir -p /home/azureuser/.kube
sudo cp /etc/kubernetes/admin.conf /home/azureuser/.kube/config
sudo chown azureuser:azureuser /home/azureuser/.kube/config
