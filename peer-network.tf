# Create a US VPC 
resource "google_compute_network" "task3_us_vpc" {
  project                 = var.project_id
  name                    = var.us_vpc_peer.vpc.name
  auto_create_subnetworks = false
  mtu                     = 1460
}

# add us east subnet to the VPC
resource "google_compute_subnetwork" "task3_us_east_subnet" {
  name          = var.us_vpc_peer.us_east1_subnet.name
  ip_cidr_range = var.us_vpc_peer.us_east1_subnet.ip_cidr_range
  region        = var.us_vpc_peer.us_east1_subnet.region
  network       = google_compute_network.task3_us_vpc.id
}

# add us west subnet to the VPC
resource "google_compute_subnetwork" "task3_us_west_subnet" {
  name          = var.us_vpc_peer.us_west1_subnet.name
  ip_cidr_range = var.us_vpc_peer.us_west1_subnet.ip_cidr_range
  region        = var.us_vpc_peer.us_west1_subnet.region
  network       = google_compute_network.task3_us_vpc.id
}
