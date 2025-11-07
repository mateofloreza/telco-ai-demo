# Jumphost Module Variables

variable "instance_name" {
  description = "Name tag for the jumphost EC2 instance"
  type        = string
  default     = "jumphost"
}

variable "instance_type" {
  description = "EC2 instance type for the jumphost"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "AMI ID for the jumphost instance. If not provided, latest Amazon Linux 2 AMI will be used"
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "VPC ID where the jumphost will be deployed"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where the jumphost will be deployed (should be a public subnet)"
  type        = string
}

variable "key_name" {
  description = "Name of the SSH key pair to use for the jumphost"
  type        = string
}

variable "create_security_group" {
  description = "Whether to create a new security group for the jumphost"
  type        = bool
  default     = true
}

variable "security_group_name" {
  description = "Name for the security group (only used if create_security_group is true)"
  type        = string
  default     = "jumphost-sg"
}

variable "additional_security_group_ids" {
  description = "List of additional security group IDs to attach to the jumphost"
  type        = list(string)
  default     = []
}

variable "trusted_ip_ranges" {
  description = "List of CIDR blocks allowed to SSH into the jumphost (e.g., office IPs, VPN ranges)"
  type        = list(string)
  default     = []

  validation {
    condition     = length(var.trusted_ip_ranges) > 0
    error_message = "At least one trusted IP range must be specified for security purposes."
  }
}

variable "associate_public_ip" {
  description = "Whether to associate a public IP address with the jumphost"
  type        = bool
  default     = true
}

variable "enable_monitoring" {
  description = "Enable detailed CloudWatch monitoring"
  type        = bool
  default     = false
}

variable "root_volume_type" {
  description = "Type of root volume (gp2, gp3, io1, io2)"
  type        = string
  default     = "gp3"
}

variable "root_volume_size" {
  description = "Size of root volume in GB"
  type        = number
  default     = 20
}

variable "root_volume_delete_on_termination" {
  description = "Whether to delete the root volume when instance is terminated"
  type        = bool
  default     = true
}

variable "root_volume_encrypted" {
  description = "Whether to encrypt the root volume"
  type        = bool
  default     = true
}

variable "user_data" {
  description = "User data script to run on instance launch"
  type        = string
  default     = null
}

variable "tags" {
  description = "Map of tags to apply to all resources"
  type        = map(string)
  default     = {}
}
