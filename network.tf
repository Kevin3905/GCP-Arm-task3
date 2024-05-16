# Create EU VPC
resource "google_compute_network" "task3_vpc" {
  project                 = var.project_id
  name                    = var.eu_vpc_host.vpc.name
  auto_create_subnetworks = false
  mtu                     = 1460
}

# add subnet to the EU VPC
resource "google_compute_subnetwork" "task3_eu_subnet" {
  name          = var.eu_vpc_host.subnet.name
  ip_cidr_range = var.eu_vpc_host.subnet.ip_cidr_range
  region        = var.eu_vpc_host.subnet.region
  network       = google_compute_network.task3_vpc.id
}
