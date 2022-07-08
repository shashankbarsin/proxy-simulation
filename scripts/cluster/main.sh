#!/bin/bash

export SQUID_NOAUTH_IP=$1
export SQUID_BASIC_IP=$2
export SQUID_CERT_IP=$3

source ./prepare-cluster-node.sh
source ./bootstrap-master-node.sh
source ./install-utils.sh
