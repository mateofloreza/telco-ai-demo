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
  default = [
    # Example: Add your office or VPN IP ranges here
    # "203.0.113.0/24",
    # "198.51.100.0/24"
  ]
}
