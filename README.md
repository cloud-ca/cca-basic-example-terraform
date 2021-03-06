# cloud.ca Terraform provider example

Basic environment creation using terraform on cloud.ca
This terraform example will create:
- an environment named "tf-demo" in the compute Quebec region,
- a VPC service with 2 network tiers as network topology,
- 2 VM instances of 2vcpu, 1GBram
- Port forwarding rule for SSH access to one VM.

This example currently work with Terraform 0.12.x.

### Install Terraform

* Install Terraform, https://www.terraform.io/downloads.html
* Install cloud.ca Terraform driver; https://github.com/cloud-ca/terraform-provider-cloudca#installation

## How to use

- generate ssh keys, with `ssh-keygen -t rsa -b 4096 -N "" -f ./id_rsa` for example
- create a file `terraform.tfvars` containing at least the following variables:
  - `api_key` = your cloud.ca API key
  - `organization_name` = name used to connect to cloud.ca - \<organization_name>.cloud.ca

`terraform.tfvars` example:

```
api_key = "<api key>"
organization_name = "demo"
```

### deploy the environment

```
terraform init
terraform validate
terraform apply
```

Once the terraform job is completed, you can ssh the web instance thru
`ssh cca-user@<PUBLIC IP> -i id_rsa`

### remove the environment from cloud.ca

```
terraform destroy
```

## Customization

Number of instances and their specs can be changed from the `variables.tf` and `instances.tf` files.
