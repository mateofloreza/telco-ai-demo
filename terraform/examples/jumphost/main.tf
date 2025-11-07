# Example usage of the Jumphost module
# This file demonstrates how to use the jumphost module in your Terraform configuration

module "jumphost_example" {
  source = "../../modules/jumphost"

  instance_name = "example-jumphost"
  instance_type = "t3.micro"
  
  # Network configuration
  vpc_id    = var.vpc_id
  subnet_id = var.public_subnet_id
  key_name  = var.ssh_key_name
  
  # Security configuration - restrict SSH to trusted IPs only
  trusted_ip_ranges = var.trusted_ip_ranges
  
  # Optional: Additional security groups
  # additional_security_group_ids = ["sg-existing123"]
  
  # Optional: Custom AMI
  # ami_id = "ami-0abcdef1234567890"
  
  # Optional: Enable monitoring
  # enable_monitoring = true
  
  # Optional: Custom volume settings
  # root_volume_type = "gp3"
  # root_volume_size = 30
  
  tags = {
    Environment = "development"
    Project     = "telco-ai-demo"
    ManagedBy   = "terraform"
  }
}

# Output values for reference
output "jumphost_public_ip" {
  description = "Public IP of the jumphost"
  value       = module.jumphost_example.public_ip
}

output "jumphost_instance_id" {
  description = "Instance ID of the jumphost"
  value       = module.jumphost_example.instance_id
}

output "jumphost_ssh_command" {
  description = "SSH command to connect to the jumphost"
  value       = "ssh -i /path/to/key.pem ec2-user@${module.jumphost_example.public_ip}"
}
