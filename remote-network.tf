# Create Asia VPC
resource "google_compute_network" "task3_asia_vpc" {
  project                 = var.project_id
  name                    = var.asia_remote.vpc.name
  auto_create_subnetworks = false
  mtu                     = 1460
}

# add subnet to the Asia VPC
resource "google_compute_subnetwork" "task3_asia_subnet" {
  name          = var.asia_remote.subnet.name
  ip_cidr_range = var.asia_remote.subnet.ip_cidr_range
  region        = var.asia_remote.subnet.region
  network       = google_compute_network.task3_asia_vpc.id
}
