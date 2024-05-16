variable "project_id" {
  type        = string
  description = "The project ID to deploy resources"
  default     = "iamagwe"
}

variable "region" {
  type        = string
  description = "The region to deploy resources"
  default     = "us-east1"
}

variable "zone" {
  type        = string
  description = "The zone to deploy resources"
  default     = "us-east1-b"
}

variable "credentials" {
  type        = string
  description = "The path to the service account key file"
  default     = "iamagwe-40a98105e9fd.json"
}

variable "location" {
  type        = string
  description = "The location to deploy resources"
  default     = "US"
}

variable "google_bucket_url" {
  type        = string
  description = "Google storage bucket URL"
  default     = "https://storage.googleapis.com/"
}

variable "firewall_name" {
  type        = string
  description = "The name of the firewall rule"
  default     = "firewall-rule"
}

variable "source_ranges" {
  type        = list(string)
  description = "Source ranges to allow traffic from"
  # default     = ["172.16.178.0/24", "172.16.179.0/24", "192.168.178.0/24", "10.178.0.0/24"]
  default = ["0.0.0.0/0"]
}

variable "ports" {
  type        = list(list(string))
  description = "Ports to open on the firewall"
  # first array is for ingress, second array is for egress
  default = [["22", "80", "3389"], ["22", "3389"]]
}

variable "eu_vpc_host" {
  type        = map(map(string))
  description = "EU VPC with subnet"
  default = {
    vpc = {
      name = "eu-host-vpc"
    }
    subnet = {
      instance_name = "eu-host"
      name          = "task3-eu-host-subnet"
      ip_cidr_range = "10.178.0.0/24"
      region        = "europe-west1"
      zone          = "europe-west1-b"
    }
  }
}

variable "us_vpc_peer" {
  type        = map(map(string))
  description = "US VPC with 2 subnets"
  default = {
    vpc = {
      name = "us-vpc-peer"
    }
    us_east1_subnet = {
      instance_name = "us-east1-peer"
      name          = "task3-us-east1-subnet"
      ip_cidr_range = "172.16.178.0/24"
      region        = "us-east1"
      zone          = "us-east1-b"
    }
    us_west1_subnet = {
      instance_name = "us-west1-peer"
      name          = "task3-us-west1-subnet"
      ip_cidr_range = "172.16.179.0/24"
      region        = "us-west1"
      zone          = "us-west1-b"
    }
  }
}

variable "asia_remote" {
  type        = map(map(string))
  description = "Asia VPC with 1 subnet"
  default = {
    vpc = {
      name = "asia-remote-vpc"
    }
    subnet = {
      instance_name = "asia-remote"
      name          = "task3-asia-southeast1"
      ip_cidr_range = "192.168.178.0/24"
      region        = "asia-southeast1"
      zone          = "asia-southeast1-b"
    }
  }
}

variable "machine_types" {
  type        = map(map(string))
  description = "values for the machine types"
  default = {
    windows = {
      image        = "projects/windows-cloud/global/images/windows-server-2022-dc-v20240415"
      size         = "120"
      type         = "pd-balanced"
      machine_type = "n2-standard-4"
    }
    linux = {
      image        = "debian-cloud/debian-12"
      size         = "10"
      type         = "pd-standard"
      machine_type = "e2-medium"
    }
  }
}
