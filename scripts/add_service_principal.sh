#
# Creates a Service Principals setup of the Azure infrastructure
#

# GUID of the subscription in which the Azure infrastructure is to be set up
export SUBSCRIPTION_ID="<SUBSCRIPTION_GUID>"

# Name of the service principal
# Customer: three characters
# Application: three characters
# Environment: max four characters dev|int|poc|prod|qa|test
export APP_NAME="<customer>-<application>-<environment>-sp-tf"

# Optional login to Azure and/or update the available subscriptions
# Login with your own account at the tenant to which the subscription is assigned
az login
az account list --refresh

# Set the scope of the subscription
az account set --subscription ${SUBSCRIPTION_ID}

# Creates the service principal
# The password expires after 5 years
az ad app create --display-name ${APP_NAME} --homepage "https://${APP_NAME}" --identifier-uris "http://${APP_NAME}"
az ad sp create-for-rbac --name ${APP_NAME} --role "Contributor" --scopes "/subscriptions/$(${SUBSCRIPTION_ID})" --years 5

# Output:
# {
#   "appId": "<GUID>",
#   "displayName": "<customer>-<application>-<environment>-sp-tf",
#   "name": "http://<customer>-<application>-<environment>-sp-tf",
#   "password": "<PASSWorD>",
#   "tenant": "<GUID>",
#   "objectId": "<GUID>"
# }

# Optional:
# If permissions are to be assigned with the service principal, then assign the role `User Access Adminstrator``.
az role assignment create --assignee "<OBJECT_ID>" --role "User Access Administrator" --scope "/subscriptions/$(${SUBSCRIPTION_ID})"

# Optional:
# Logout
az logout
