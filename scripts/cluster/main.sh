#!/bin/bash

export SQUID_NOAUTH_IP=$1
export SQUID_BASIC_IP=$2
export SQUID_CERT_IP=$3
export CONNECTEDK8S_SOURCE=$4
export K8S_EXTENSION_SOURCE=$5
export K8SCONFIGURATION_SOURCE=$6

source ./prepare-cluster-node.sh
source ./bootstrap-master-node.sh
source ./install-utils.sh
