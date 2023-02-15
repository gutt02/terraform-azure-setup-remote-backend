# Local deployment of Azure resources, the state file is stored in an Azure Storage Account.
# Azure CLI must be installed
# terraform must be in the PATH

$ENV:ARM_CLIENT_ID="<APPLICATION_GUID>"
$ENV:ARM_CLIENT_SECRET="<PASSWORD>"
$ENV:ARM_SUBSCRIPTION_ID="<SUBSCRIPTION_GUID>"
$ENV:ARM_TENANT_ID="<TENANT_GUID>"

$ENV:TF_VAR_client_secret=$ENV:ARM_CLIENT_SECRET
$ENV:TF_VAR_<NAME>="<VALUE>"

# Customer: three characters
# Application: three characters
# Environment: max four characters dev|int|poc|prod|qa|test
$ENV:TF_STATE_RESOURCE_GROUP_NAME="<customer>-<application>-<environment>-rg-tf"
$ENV:TF_STATE_ENV="<customer>-<application>-<environment>"
$ENV:TF_STATE_STORAGE_ACCOUNT_NAME="<STORAGE_ACCOUNT_NAME>"
$ENV:TF_STATE_CONTAINER_NAME="statefiles"
$ENV:TF_STATE_KEY="$ENV:TF_STATE_ENV.tfstate"

$ENV:TF_CLI_ARGS_init="-backend-config=resource_group_name=$ENV:TF_STATE_RESOURCE_GROUP_NAME"
$ENV:TF_CLI_ARGS_init="$ENV:TF_CLI_ARGS_init -backend-config=storage_account_name=$ENV:TF_STATE_STORAGE_ACCOUNT_NAME"
$ENV:TF_CLI_ARGS_init="$ENV:TF_CLI_ARGS_init -backend-config=container_name=$ENV:TF_STATE_CONTAINER_NAME"
$ENV:TF_CLI_ARGS_init="$ENV:TF_CLI_ARGS_init -backend-config=key=$ENV:TF_STATE_KEY"

$ENV:TF_CLI_ARGS_plan="-var-file=.\\environments\\$ENV:TF_STATE_ENV.tfvars"
$ENV:TF_CLI_ARGS_apply="-var-file=.\\environments\\$ENV:TF_STATE_ENV.tfvars"
$ENV:TF_CLI_ARGS_destroy="-var-file=.\\environments\\$ENV:TF_STATE_ENV.tfvars"
$ENV:TF_CLI_ARGS_import="-var-file=.\\environments\\$ENV:TF_STATE_ENV.tfvars"
$ENV:TF_CLI_ARGS_refresh="-var-file=.\\environments\\$ENV:TF_STATE_ENV.tfvars"

# terraform init
# terraform plan
# terraform apply
# terraform destroy
# terraform refresh
