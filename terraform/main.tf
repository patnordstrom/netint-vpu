resource "random_password" "root_pass" {
  length  = 30
  special = true
}

# This is the template for cloud-init for configuring the VPU server
# with it's dependencies
data "template_file" "vpu_server_config" {
  template = file("${path.module}/templates/netint-vpu-config.yaml")
  vars = {
    netint_quadra_sw_download_url = var.netint_quadra_sw_download_url
    ffmpeg_version                = var.ffmpeg_version
    netint_quadra_sw_version      = var.netint_quadra_sw_version
  }
}

resource "linode_instance" "vpu_server" {
  label            = var.node_label
  region           = var.region
  image            = var.image_name
  type             = var.image_type
  root_pass        = random_password.root_pass.result
  authorized_users = var.authorized_users
  metadata {
    user_data = base64encode(data.template_file.vpu_server_config.rendered)
  }
}

resource "linode_firewall" "vpu_server_firewall" {
  label = "${var.node_label}-fw"

  inbound_policy  = "DROP"
  outbound_policy = "ACCEPT"

  inbound {
    label    = "allow-ssh-from-my-computer"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "22"
    ipv4     = var.allowed_ssh_user_ips
  }

  linodes = [linode_instance.vpu_server.id]

}