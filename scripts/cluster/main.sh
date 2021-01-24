#!/bin/bash

export SQUID_NOAUTH_IP=$1
#export SQUID_BASIC_IP=$2
export SQUID_CERT_IP=$2
export CONNECTEDK8S_SOURCE=$3
export K8S_EXTENSION_SOURCE=$4
export K8SCONFIGURATION_SOURCE=$5

source ./prepare-cluster-node.sh
source ./bootstrap-master-node.sh
source ./install-utils.sh
