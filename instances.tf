resource "cloudca_ssh_key" "demo_ssh_key" {
    environment_id = cloudca_environment.default.id
    name           = "demo_ssh_key"
    public_key     = file("./id_rsa.pub")
}

resource "cloudca_instance" "web_instance" {
  environment_id   = cloudca_environment.default.id
  count            = var.frontend_count
  name             = format("%s-web-%02d", var.environment_name, count.index + 1)
  network_id       = cloudca_network.web_network.id
  template         = var.template_name
  compute_offering = "Standard"
  cpu_count        = 2
  memory_in_mb     = 1024
  ssh_key_name     = "demo_ssh_key"
}

resource "cloudca_instance" "db_instance" {
  environment_id   = cloudca_environment.default.id
  count            = var.backend_count
  name             = format("%s-db-%02d", var.environment_name, count.index + 1)
  network_id       = cloudca_network.db_network.id
  template         = var.template_name
  compute_offering = "Standard"
  cpu_count        = 2
  memory_in_mb     = 1024
  ssh_key_name     = "demo_ssh_key"
}

resource "cloudca_volume" "db_volume" {
  environment_id = cloudca_environment.default.id
  count          = var.backend_count
  name           = "DATA_${element(cloudca_instance.db_instance.*.name, count.index)}"
  disk_offering  = "Performance, No QoS"
  size_in_gb     = 10
  instance_id    = element(cloudca_instance.db_instance.*.id, count.index)
}

resource "cloudca_public_ip" "web_ssh" {
  environment_id = cloudca_environment.default.id
  vpc_id         = cloudca_vpc.default.id
}

resource "cloudca_port_forwarding_rule" "web_ssh" {
  environment_id    = cloudca_environment.default.id
  public_ip_id      = cloudca_public_ip.web_ssh.id
  public_port_start = 22
  private_ip_id     = cloudca_instance.web_instance.0.private_ip_id
  private_port_start = 22
  protocol           = "TCP"
}
output "ssh" {
  value = "Connect to the web frontend instance using: `ssh ${var.username}@${cloudca_public_ip.web_ssh.ip_address} -i id_rsa`"
}