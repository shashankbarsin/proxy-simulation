# Install Azure CLI

sudo apt-get update
sudo apt-get install -y ca-certificates curl apt-transport-https lsb-release gnupg

curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null

AZ_REPO=$(lsb_release -cs)
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | sudo tee /etc/apt/sources.list.d/azure-cli.list

sudo apt-get update
sudo apt-get install -y azure-cli

if [[ -z "${CONNECTEDK8S_SOURCE}" ]];
then
  az extension add --name connectedk8s
else
  az extension add --source $CONNECTEDK8S_SOURCE
fi

if [[ -z "${K8SCONFIGURATION_SOURCE}" ]];
then
  az extension add --name k8sconfiguration
else
  az extension add --source $K8SCONFIGURATION_SOURCE
fi

if [[ "${K8S_EXTENSION_SOURCE}" ]];
then
az extension add --source $K8S_EXTENSION_SOURCE
fi

# Install Helm 3

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
