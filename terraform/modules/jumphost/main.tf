# Jumphost (Bastion Host) Module
# This module provisions a secure EC2 instance to act as a jumphost for accessing private resources

# Get the latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Security group for jumphost
resource "aws_security_group" "jumphost" {
  count       = var.create_security_group ? 1 : 0
  name        = var.security_group_name
  description = "Security group for jumphost/bastion host"
  vpc_id      = var.vpc_id

  # SSH access from trusted IP ranges
  ingress {
    description = "SSH from trusted IPs"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.trusted_ip_ranges
  }

  # Allow all outbound traffic
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    {
      Name = var.security_group_name
    }
  )
}

# EC2 Instance for jumphost
resource "aws_instance" "jumphost" {
  ami           = var.ami_id != "" ? var.ami_id : data.aws_ami.amazon_linux_2.id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  key_name      = var.key_name

  vpc_security_group_ids = var.create_security_group ? concat([aws_security_group.jumphost[0].id], var.additional_security_group_ids) : var.additional_security_group_ids

  # Validate that at least one security group is attached
  lifecycle {
    precondition {
      condition     = var.create_security_group || length(var.additional_security_group_ids) > 0
      error_message = "At least one security group must be attached. Either set create_security_group=true or provide additional_security_group_ids."
    }
  }

  # Enable detailed monitoring if specified
  monitoring = var.enable_monitoring

  # Associate public IP if specified
  associate_public_ip_address = var.associate_public_ip

  # Root block device configuration
  root_block_device {
    volume_type           = var.root_volume_type
    volume_size           = var.root_volume_size
    delete_on_termination = var.root_volume_delete_on_termination
    encrypted             = var.root_volume_encrypted
  }

  # User data for initial setup (optional)
  user_data = var.user_data

  # Instance metadata options for security
  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required" # IMDSv2 required for better security
    http_put_response_hop_limit = 1
  }

  tags = merge(
    var.tags,
    {
      Name = var.instance_name
    }
  )
}
