resource "cloudca_network" "db_network" {
  environment_id   = cloudca_environment.default.id
  name             = "database_network"
  description      = var.db_network_description
  vpc_id           = cloudca_vpc.default.id
  network_offering = "Standard Tier"
  network_acl      = "default_allow"
}