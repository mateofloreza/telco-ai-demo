# Variables for the jumphost example

variable "vpc_id" {
  description = "VPC ID where the jumphost will be deployed"
  type        = string
}

variable "public_subnet_id" {
  description = "Public subnet ID for the jumphost"
  type        = string
}

variable "ssh_key_name" {
  description = "Name of the SSH key pair"
  type        = string
}

variable "trusted_ip_ranges" {
  description = "List of CIDR blocks allowed to SSH into the jumphost"
  type        = list(string)
  # Note: No default value - you must specify trusted IP ranges for security
  # Example values:
  # trusted_ip_ranges = [
  #   "203.0.113.0/24",  # Office network
  #   "198.51.100.0/24"  # VPN network
  # ]
}
