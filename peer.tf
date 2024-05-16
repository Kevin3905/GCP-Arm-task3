# # add 2 compute instance to the VPC

# add compute instance to the US East VPC
resource "google_compute_instance" "us_east1_peer" {
  name         = var.us_vpc_peer.us_east1_subnet.instance_name
  machine_type = var.machine_types.linux.machine_type
  zone         = var.us_vpc_peer.us_east1_subnet.zone


  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
      size  = 10
    }
    # true by default
    auto_delete = true
  }

  network_interface {
    network    = var.us_vpc_peer.vpc.name
    subnetwork = var.us_vpc_peer.us_east1_subnet.name

    # external IP
    access_config {
      // Ephemeral public IP
    }
  }

  depends_on = [google_compute_network.task3_us_vpc,
  google_compute_subnetwork.task3_us_east_subnet]
  # depends_on = [google_compute_network.task3_vpc,
  # google_compute_subnetwork.task3_eu_subnet, google_compute_firewall.rules]
}

# add compute instance to the US west VPC
resource "google_compute_instance" "us_west1_peer" {
  name         = var.us_vpc_peer.us_west1_subnet.instance_name
  machine_type = var.machine_types.linux.machine_type
  zone         = var.us_vpc_peer.us_west1_subnet.zone


  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
      size  = 10
    }
    # true by default
    auto_delete = true
  }

  network_interface {
    network    = var.us_vpc_peer.vpc.name
    subnetwork = var.us_vpc_peer.us_west1_subnet.name

    # external IP
    access_config {
      // Ephemeral public IP
    }
  }

  depends_on = [google_compute_network.task3_us_vpc,
  google_compute_subnetwork.task3_us_west_subnet]
  # depends_on = [google_compute_network.task3_vpc,
  # google_compute_subnetwork.task3_eu_subnet, google_compute_firewall.rules]
}

