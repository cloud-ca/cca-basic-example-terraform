# Provider credentials
variable "api_key" {}

# General variables
variable "is_production" {
  default = false
}

variable "frontend_count" {
  default = 1
}
variable "backend_count" {
  default = 1
}

# Environment
variable "service_code" {
  default = "compute-qc"
}

variable "organization_name" {}
variable "environment_name" {
  default = "tf-demo"
}

variable "environment_description" {
  default = "Demo environment from Terraform"
}

# VPC
variable "vpc_offering" {
  default = "Default VPC offering"
}

variable "zone_id" {
  default = "QC-2"
}

variable "vpc_description" {
  default = "VPC for demo workloads"
}

# Networks
variable "web_network_description" {
  default = "Web network"
}

variable "db_network_description" {
  default = "Database network"
}

# Instances
variable "template_name" {
  default = "CentOS 7"
}

variable "username" {
  default = "cca-user"
}

variable "web_ports" {
  default = [80, 443]
}
