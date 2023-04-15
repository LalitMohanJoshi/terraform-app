# Terraform Application Demo - [ AWS , AZURE, ORACLE]

This repositery contain terraform configuration for multiple cloud providers.
It contain the basic demo to setup virtual cloud & associate service using terraform.

## Installation

Use the package manager [Terraform](https://releases.hashicorp.com/terraform/1.4.5/terraform_1.4.5_windows_386.zip) to install the Application.

```bash
# logic tfc 

terraform login

# apply terraform config fils

terraform apply

# apply terraform config fils with auto approve

terraform apply --auto-approve

# check tfc plan 
terraform init

terraform plan

# destroy tfc resources

terraform destroy --auto-approve

# format tf files

terraform fmt

# validate tfc file configuration

terraform validate