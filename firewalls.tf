# firewall rules 
resource "google_compute_firewall" "rules" {
  project     = var.project_id
  name        = "allow-remote-peer"
  network     = var.eu_vpc_host.vpc.name
  description = "Creates firewall rule targeting instance IP sources"

  # allow {
  #   protocol = "tcp"
  #   ports    = var.ports[0]
  # }
  # direction     = "INGRESS"
  # source_ranges = var.source_ranges

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "22", "3389"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "rules_peering" {
  project     = var.project_id
  name        = "allow-peering"
  network     = var.us_vpc_peer.vpc.name
  description = "Creates firewall rule targeting instance IP sources"

  # allow {
  #   protocol = "tcp"
  #   ports    = var.ports[1]
  # }
  # direction     = "EGRESS"
  # source_ranges = var.source_ranges

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "22", "3389"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "rules_remote" {
  project     = var.project_id
  name        = "allow-remote"
  network     = var.asia_remote.vpc.name
  description = "Creates firewall rule targeting instance IP sources"

  # allow {
  #   protocol = "tcp"
  #   ports    = var.ports[1]
  # }
  # direction     = "EGRESS"
  # source_ranges = var.source_ranges

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "22", "3389"]
  }

  source_ranges = ["0.0.0.0/0"]
}

