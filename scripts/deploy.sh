#!/bin/bash

echo "... Loading globals"
. ./variables.sh

echo ".................................................." 
echo ">>> Creating resources for [$INFRACODE] <<<"
echo ".................................................." 

echo "${DBG}... Create resource group [$RESOURCE_GROUP]"
az group create -l $LOCATION -n $RESOURCE_GROUP

echo "${DBG}... Creating AKS [$AKS_NAME]"
az aks create -g $RESOURCE_GROUP -n $AKS_NAME \
  --kubernetes-version "1.27.3" \
  --node-count 1 \
  --enable-cluster-autoscaler \
  --min-count 1 \
  --max-count 3 \
  --enable-aad \
  --aad-admin-group-object-ids $AKS_AD_AKSADMIN_GROUP_ID \
  --aad-tenant-id $AZURE_AD_TENANTID \
  --enable-oidc-issuer \
  --os-sku AzureLinux \
  --enable-asm --enable-workload-identity --generate-ssh-keys

echo "${DBG}... Get pods from all namespaces"

echo "${DBG}... Script completed"