provider "cloudca" {
  api_key = var.api_key
}

resource "cloudca_environment" "default" {
  service_code      = var.service_code
  organization_code = var.organization_name
  name              = var.environment_name
  description       = var.environment_description
}

resource "cloudca_vpc" "default" {
  environment_id = cloudca_environment.default.id
  name           = var.environment_name
  description    = var.vpc_description
  vpc_offering   = var.vpc_offering
  zone           = var.zone_id
}

resource "cloudca_public_ip" "public_endpoint" {
  environment_id = cloudca_environment.default.id
  vpc_id         = cloudca_vpc.default.id
}
