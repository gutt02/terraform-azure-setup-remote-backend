#
# Creates the Azure Storage Account  in which the state files for building the Azure resource are to be stored.
#

export TENANT_ID="<TENANT_GUID>"
export SUBSCRIPTION_ID="<SUBSCRIPTION_GUID>"
# GUID of the service principal from add_service_principal.sh
export CLIENT_ID="<APPLICATION_GUID>"
# Object Id of the service principal from add_service_principal.sh
export OBJECT_ID="<OBJECT_ID>"
# Client secret of the service principal
export CLIENT_SECRET="<PASSWORD>"
# Customer: three characters
# Application: three characters
# Environment: max four characters dev|int|poc|prod|qa|test
export RESOURCE_GROUP_NAME="<customer>-<application>-<environment>-rg-tf"
# Azure Region
export LOCATION="westeurope"
export STORAGE_ACCOUNT_NAME="<customer><application><environment>strgtf"
export CONTAINER_NAME="statefiles"

export CREATED_BY="<SERVICE_PRINCIPAL_NAME>"
export CONTACT="<E-MAIL_OF_CONTACT>"
export CUSTOMER="<FULL_CUSTOMER_NAME>"
export ENVIRONMENT="<ENVIRONMENT_LONG>"
export PROJECT="<PROJECT_NAME>"

# Login with the service principal and selecting the subscription
az login --service-principal --username ${CLIENT_ID} --password ${CLIENT_SECRET} --tenant ${TENANT_ID}
az account set --subscription ${SUBSCRIPTION_ID}
az group create --name ${RESOURCE_GROUP_NAME} --location ${LOCATION} --tags "created_by=${CREATED_BY}" "contact=${CONTACT}" "customer=${CUSTOMER}" "environment=${ENVIRONMENT}" "project=${PROJECT}"
az storage account create --name ${STORAGE_ACCOUNT_NAME} --resource-group ${RESOURCE_GROUP_NAME} --access-tier Hot --https-only true --kind StorageV2 --location ${LOCATION} --sku Standard_LRS
az storage container create --name ${CONTAINER_NAME} --account-name ${STORAGE_ACCOUNT_NAME}
az role assignment create --assignee ${OBJECT_ID} --role "Storage Account Contributor" --scope "/subscriptions/${SUBSCRIPTION_ID}/resourceGroups/${RESOURCE_GROUP_NAME}/providers/Microsoft.Storage/storageAccounts/${STORAGE_ACCOUNT_NAME}"
az role assignment create --assignee ${OBJECT_ID} --role "Storage Blob Data Contributor" --scope "/subscriptions/${SUBSCRIPTION_ID}/resourceGroups/${RESOURCE_GROUP_NAME}/providers/Microsoft.Storage/storageAccounts/${STORAGE_ACCOUNT_NAME}"

# Optional:
# Network rules for the Storage Account
# ASY networks https://ipinfo.io/AS33873
# 84.17.160.0/19, 109.235.136.0/21, 145.228.0.0/16
# az storage account update --name $storageAccountName --resource-group $resourceGroupName --default-action Deny
# az storage account network-rule add --account-name $storageAccountName --resource-group $resourceGroupName --ip-address 84.17.160.0/19
# az storage account network-rule add --account-name $storageAccountName --resource-group $resourceGroupName --ip-address 109.235.136.0/21
# az storage account network-rule add --account-name $storageAccountName --resource-group $resourceGroupName --ip-address 145.228.0.0/16
# az storage container create --name $containerName --account-name $storageAccountName --public-access off
