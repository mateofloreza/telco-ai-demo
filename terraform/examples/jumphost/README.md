# Jumphost Module Example

This directory contains an example of how to use the jumphost module.

## Prerequisites

Before using this example, ensure you have:

1. An AWS account with appropriate permissions
2. Terraform installed (>= 1.0)
3. An existing VPC with at least one public subnet
4. An SSH key pair created in AWS
5. Your trusted IP addresses identified

## Usage

1. Copy `terraform.tfvars.example` to `terraform.tfvars`:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

2. Edit `terraform.tfvars` with your values:
   ```hcl
   vpc_id             = "vpc-12345678"
   public_subnet_id   = "subnet-12345678"
   ssh_key_name       = "my-ssh-key"
   trusted_ip_ranges  = ["YOUR_IP/32"]
   ```

3. Initialize Terraform:
   ```bash
   terraform init
   ```

4. Plan the deployment:
   ```bash
   terraform plan
   ```

5. Apply the configuration:
   ```bash
   terraform apply
   ```

## Connecting to the Jumphost

After deployment, connect using:

```bash
ssh -i /path/to/your-key.pem ec2-user@<public_ip>
```

The public IP will be displayed in the Terraform outputs.

## Cleanup

To destroy the resources:

```bash
terraform destroy
```
