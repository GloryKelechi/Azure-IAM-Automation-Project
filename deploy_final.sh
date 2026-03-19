
#!/bin/bash

RG_NAME="Glory-Secure-RG"

LOCATION="eastus"

VNET_NAME="SecureVeeNet"

WEB_SUBNET="WebSubNet"

DB_SUBNET="DBSubNet"



echo "1. Creating Resource Group..."

az group create --name "$RG_NAME" --location "$LOCATION"



echo "2. Creating VNet and Subnets..."

az network vnet create -g "$RG_NAME" -n "$VNET_NAME" --address-prefix 10.0.0.0/16 \

  --subnet-name "$WEB_SUBNET" --subnet-prefix 10.0.1.0/24



az network vnet subnet create -g "$RG_NAME" -n "$DB_SUBNET" \

  --vnet-name "$VNET_NAME" --address-prefix 10.0.2.0/24



echo "3. Creating AD Groups..."

WEB_ID=$(az ad group create --display-name "WebAdmins" --mail-nickname "WebAdmins" --query id -o tsv)

DB_ID=$(az ad group create --display-name "DBAdmins" --mail-nickname "DBAdmins" --query id -o tsv)



echo "4. Assigning Role..."

SUB_ID=$(az account show --query id -o tsv)

SCOPE="/subscriptions/$SUB_ID/resourceGroups/$RG_NAME/providers/Microsoft.Network/virtualNetworks/$VNET_NAME/subnets/$DB_SUBNET"



az role assignment create --assignee "$DB_ID" --role "Reader" --scope "$SCOPE"

echo "DEPLOYMENT COMPLETE!"

