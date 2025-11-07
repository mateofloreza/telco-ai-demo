# Terraform AWS Jumphost (Bastion Host) Module

This Terraform module provisions a secure EC2 instance to act as a jumphost (bastion host) for accessing private resources in your AWS VPC.

## Features

- 🔒 **Secure by Default**: Restricts SSH access to trusted IP ranges only
- 🛡️ **IMDSv2 Required**: Enforces IMDSv2 for enhanced security
- 💾 **Encrypted Storage**: Root volume encryption enabled by default
- ⚙️ **Highly Configurable**: Supports custom instance types, AMIs, and security settings
- 🏷️ **Flexible Tagging**: Apply custom tags to all resources
- 📊 **Monitoring Support**: Optional detailed CloudWatch monitoring

## Security Best Practices

This module implements several AWS security best practices:

1. **Restricted SSH Access**: SSH (port 22) is only allowed from explicitly trusted IP ranges
2. **IMDSv2 Required**: Instance metadata service v2 is enforced for better security
3. **Encrypted Volumes**: Root volume is encrypted by default
4. **Minimal Permissions**: Only necessary egress traffic is allowed
5. **Latest AMI**: Uses the latest Amazon Linux 2 AMI by default (or custom AMI)

## Usage

### Basic Example

```hcl
module "jumphost" {
  source = "./terraform/modules/jumphost"

  instance_name = "my-jumphost"
  instance_type = "t3.micro"
  
  vpc_id    = "vpc-12345678"
  subnet_id = "subnet-12345678"  # Should be a public subnet
  key_name  = "my-ssh-key"
  
  trusted_ip_ranges = [
    "203.0.113.0/24",  # Office network
    "198.51.100.0/24"  # VPN network
  ]
  
  tags = {
    Environment = "production"
    Project     = "telco-ai-demo"
    ManagedBy   = "terraform"
  }
}
```

### Advanced Example

```hcl
module "jumphost" {
  source = "./terraform/modules/jumphost"

  instance_name = "advanced-jumphost"
  instance_type = "t3.small"
  ami_id        = "ami-0abcdef1234567890"  # Custom AMI
  
  vpc_id    = "vpc-12345678"
  subnet_id = "subnet-12345678"
  key_name  = "my-ssh-key"
  
  # Security configuration
  create_security_group         = true
  security_group_name           = "jumphost-sg"
  additional_security_group_ids = ["sg-existing123"]
  trusted_ip_ranges             = ["203.0.113.0/24"]
  
  # Instance configuration
  associate_public_ip = true
  enable_monitoring   = true
  
  # Storage configuration
  root_volume_type                  = "gp3"
  root_volume_size                  = 30
  root_volume_encrypted             = true
  root_volume_delete_on_termination = true
  
  # User data for initial setup
  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y htop
  EOF
  
  tags = {
    Environment = "production"
    Project     = "telco-ai-demo"
    ManagedBy   = "terraform"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| aws | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 4.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| vpc_id | VPC ID where the jumphost will be deployed | `string` | n/a | yes |
| subnet_id | Subnet ID where the jumphost will be deployed (should be a public subnet) | `string` | n/a | yes |
| key_name | Name of the SSH key pair to use for the jumphost | `string` | n/a | yes |
| trusted_ip_ranges | List of CIDR blocks allowed to SSH into the jumphost | `list(string)` | n/a | yes |
| instance_name | Name tag for the jumphost EC2 instance | `string` | `"jumphost"` | no |
| instance_type | EC2 instance type for the jumphost | `string` | `"t3.micro"` | no |
| ami_id | AMI ID for the jumphost instance. If not provided, latest Amazon Linux 2 AMI will be used | `string` | `""` | no |
| create_security_group | Whether to create a new security group for the jumphost | `bool` | `true` | no |
| security_group_name | Name for the security group (only used if create_security_group is true) | `string` | `"jumphost-sg"` | no |
| additional_security_group_ids | List of additional security group IDs to attach to the jumphost | `list(string)` | `[]` | no |
| associate_public_ip | Whether to associate a public IP address with the jumphost | `bool` | `true` | no |
| enable_monitoring | Enable detailed CloudWatch monitoring | `bool` | `false` | no |
| root_volume_type | Type of root volume (gp2, gp3, io1, io2) | `string` | `"gp3"` | no |
| root_volume_size | Size of root volume in GB | `number` | `20` | no |
| root_volume_delete_on_termination | Whether to delete the root volume when instance is terminated | `bool` | `true` | no |
| root_volume_encrypted | Whether to encrypt the root volume | `bool` | `true` | no |
| user_data | User data script to run on instance launch | `string` | `null` | no |
| tags | Map of tags to apply to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| instance_id | ID of the jumphost EC2 instance |
| instance_arn | ARN of the jumphost EC2 instance |
| public_ip | Public IP address of the jumphost (if associated) |
| private_ip | Private IP address of the jumphost |
| public_dns | Public DNS name of the jumphost (if associated) |
| private_dns | Private DNS name of the jumphost |
| security_group_id | ID of the security group created for the jumphost (if created) |
| security_group_arn | ARN of the security group created for the jumphost (if created) |
| key_name | Name of the SSH key pair used by the jumphost |
| availability_zone | Availability zone where the jumphost is deployed |

## Accessing the Jumphost

Once deployed, you can SSH into the jumphost using:

```bash
ssh -i /path/to/your-key.pem ec2-user@<public_ip>
```

Replace `<public_ip>` with the value from the `public_ip` output.

## Security Considerations

1. **Trusted IP Ranges**: Always restrict `trusted_ip_ranges` to the minimum required set of IPs
2. **Key Management**: Store SSH private keys securely and never commit them to version control
3. **Regular Updates**: Keep the AMI and packages updated regularly
4. **Monitoring**: Consider enabling detailed monitoring for production environments
5. **MFA**: Consider implementing MFA for SSH access in highly sensitive environments

## License

This module is part of the telco-ai-demo project.
