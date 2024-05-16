# add compute instance to the US East VPC
resource "google_compute_instance" "asia_remote" {
  name         = var.asia_remote.subnet.instance_name
  machine_type = var.machine_types.windows.machine_type
  zone         = var.asia_remote.subnet.zone


  boot_disk {
    initialize_params {
      image = var.machine_types.windows.image
      size  = tonumber(var.machine_types.windows.size)
      type  = var.machine_types.windows.type
    }
    # true by default
    auto_delete = true
  }

  network_interface {
    network    = var.asia_remote.vpc.name
    subnetwork = var.asia_remote.subnet.name

    # external IP
    access_config {
      // Ephemeral public IP
    }
  }

  depends_on = [google_compute_network.task3_asia_vpc,
  google_compute_subnetwork.task3_asia_subnet]
  # depends_on = [google_compute_network.task3_vpc,
  # google_compute_subnetwork.task3_eu_subnet, google_compute_firewall.rules]
}
