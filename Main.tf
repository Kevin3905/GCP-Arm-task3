# Americas: 2 regions - linux machines
# us-east1  - IP CIDR range 172.16.178.0/24
# us-west1  - IP CIDR range 172.16.179.0/24
# open port 80 and 22
# vpc peering with HQ

# Asia Pacific - Windows machine
# asia-southeast1 - IP CIDR range 192.168.178.0/24
# open port 3389
# VPN

# VPC - task3-network
# Europe - Host
# Subnet Europe - task3-eu-host
# location: europe-west1
# IP CIDR range: 10.178.0.0/24
# Linux machine

# VPC - For Americas
# Americas - Linux machines
# Subnet America East - task3-us-east1
# location: us-east1
# IP CIDR range 172.16.178.0/24
# Subnet America West - task3-us-west1
# location: us-west1
# IP CIDR range 172.16.179.0/24

# VPC - For Asia Pacific
# Asia Pacific - Windows machine
# Subnet Asia Pacific - task3-asia-remote
# location: asia-southeast1
# IP CIDR range 192.168.178.0/24

# EU VPC 
# 1 Subnet EU

# Americas VPC
# 2 Subnet Americas

# Asia Pacific VPC
# 1 Subnet Asia Pacific

# Deliverables.
# 1) Complete Terraform for the entire solution.
# 2) Git Push of the solution to your GitHub.
# 3) Screenshots showing how the HQ homepage was accessed from both the Americas and Asia Pacific. 


# add compute instance to the VPC
resource "google_compute_instance" "eu_host" {
  name         = var.eu_vpc_host.subnet.instance_name
  machine_type = var.machine_types.linux.machine_type
  zone         = var.eu_vpc_host.subnet.zone


  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
      size  = 10
    }
    # true by default
    auto_delete = true
  }

  network_interface {
    network    = var.eu_vpc_host.vpc.name
    subnetwork = var.eu_vpc_host.subnet.name

    # external IP
    # access_config {
    #   // Ephemeral public IP
    # }
  }

  tags = ["http-server"]

  # metadata = {
  #   startup-script-url = "${file("startup.sh")}"
  # }

  metadata_startup_script = file("startup.sh")

  # metadata_startup_script = <<-EOF
  #   #!/bin/bash
  #   apt-get update
  #   apt-get install -y apache2
  #   cat <<EOT > /var/www/html/index.html
  #   <html>
  #     <head>
  #       <title>Welcome to My Homepage</title>
  #     </head>
  #     <body>
  #       <h1>Welcome to My Homepage!</h1>
  #       <p>This page is served by Apache on a Google Compute Engine VM instance.</p>
  #     </body>
  #   </html>
  #   EOT
  # EOF
  depends_on = [google_compute_network.task3_vpc,
  google_compute_subnetwork.task3_eu_subnet]
  # depends_on = [google_compute_network.task3_vpc,
  # google_compute_subnetwork.task3_eu_subnet, google_compute_firewall.rules]
}



