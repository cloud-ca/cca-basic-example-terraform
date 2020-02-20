resource "cloudca_network" "web_network" {
  environment_id   = cloudca_environment.default.id
  name             = "web_network"
  description      = var.web_network_description
  vpc_id           = cloudca_vpc.default.id
  network_offering = "Load Balanced Tier"
  network_acl      = "default_allow"
}