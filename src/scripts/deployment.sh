# Local deployment of Azure resources, the state file is stored in an Azure Storage Account.
# Azure CLI must be installed
# terraform must be in the PATH

export ARM_CLIENT_ID="<APPLICATION_GUID>"
export ARM_CLIENT_SECRET="<PASSWORD>"
export ARM_SUBSCRIPTION_ID="<SUBSCRIPTION_GUID>"
export ARM_TENANT_ID="<TENANT_GUID>"

export TF_VAR_client_secret=${ARM_CLIENT_SECRET}
export TF_VAR_<NAME>="<VALUE>"

# Customer: three characters
# Application: three characters
# Environment: max four characters dev|int|poc|prod|qa|test
export TF_STATE_RESOURCE_GROUP_NAME="<customer>-<application>-<environment>-rg-tf"
export TF_STATE_ENV="<customer>-<application>-<environment>"
export TF_STATE_STORAGE_ACCOUNT_NAME="<STORAGE_ACCOUNT_NAME>"
export TF_STATE_CONTAINER_NAME="statefiles"
export TF_STATE_KEY="${TF_STATE_ENV}.tfstate"

export TF_CLI_ARGS_init="-backend-config=resource_group_name=${TF_STATE_RESOURCE_GROUP_NAME}"
TF_CLI_ARGS_init="${TF_CLI_ARGS_init} -backend-config=storage_account_name=${TF_STATE_STORAGE_ACCOUNT_NAME}"
TF_CLI_ARGS_init="${TF_CLI_ARGS_init} -backend-config=container_name=${TF_STATE_CONTAINER_NAME}"
TF_CLI_ARGS_init="${TF_CLI_ARGS_init} -backend-config=key=${TF_STATE_KEY}"

export TF_CLI_ARGS_plan="-var-file=./environments/${TF_STATE_ENV}.tfvars"
export TF_CLI_ARGS_apply="-var-file=./environments/${TF_STATE_ENV}.tfvars"
export TF_CLI_ARGS_destroy="-var-file=./environments/${TF_STATE_ENV}.tfvars"
export TF_CLI_ARGS_import="-var-file=./environments/${TF_STATE_ENV}.tfvars"
export TF_CLI_ARGS_refresh="-var-file=./environments/${TF_STATE_ENV}.tfvars"

# terraform init
# terraform plan
# terraform apply
# terraform destroy
# terraform refresh

# Allow installation of additional extensions
az config set extension.use_dynamic_install=yes_without_prompt
