# Telco AI Demo - Terraform Infrastructure

This repository contains Terraform modules and configurations for deploying infrastructure on AWS for the Telco AI Demo project.

## 🚀 Quick Start

This repository provides reusable Terraform modules for AWS infrastructure deployment.

## 📦 Available Modules

### Jumphost (Bastion Host) Module

A secure, production-ready Terraform module for deploying an EC2 jumphost (bastion host) on AWS.

**Location**: `terraform/modules/jumphost/`

**Features**:
- 🔒 Secure SSH access restricted to trusted IP ranges
- 🛡️ IMDSv2 enforcement for enhanced security
- 💾 Encrypted root volumes by default
- ⚙️ Highly configurable instance settings
- 🏷️ Flexible tagging support

**Quick Example**:
```hcl
module "jumphost" {
  source = "./terraform/modules/jumphost"

  instance_name = "my-jumphost"
  instance_type = "t3.micro"
  
  vpc_id    = "vpc-12345678"
  subnet_id = "subnet-12345678"
  key_name  = "my-ssh-key"
  
  trusted_ip_ranges = [
    "203.0.113.0/24",  # Office network
  ]
  
  tags = {
    Environment = "production"
    Project     = "telco-ai-demo"
  }
}
```

**Documentation**: See [terraform/modules/jumphost/README.md](terraform/modules/jumphost/README.md) for complete documentation.

**Example Usage**: See [terraform/examples/jumphost/](terraform/examples/jumphost/) for a complete working example.

## 📋 Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- AWS Account with appropriate permissions
- AWS CLI configured with credentials

## 🏗️ Project Structure

```
.
├── terraform/
│   ├── modules/
│   │   └── jumphost/          # Jumphost module
│   │       ├── main.tf
│   │       ├── variables.tf
│   │       ├── outputs.tf
│   │       ├── versions.tf
│   │       └── README.md
│   └── examples/
│       └── jumphost/          # Example usage
│           ├── main.tf
│           ├── variables.tf
│           ├── terraform.tfvars.example
│           └── README.md
├── README.md
└── LICENSE
```

## 🔒 Security Best Practices

All modules in this repository follow AWS and Terraform security best practices:

1. **Least Privilege Access**: Resources are configured with minimal required permissions
2. **Encryption**: Encryption is enabled by default where applicable
3. **IMDSv2**: Instance Metadata Service v2 is enforced
4. **Network Security**: Security groups follow the principle of least privilege
5. **No Hardcoded Secrets**: All sensitive values are passed via variables

## 📚 Usage

1. Choose a module from `terraform/modules/`
2. Review the module's README for documentation
3. Check the corresponding example in `terraform/examples/`
4. Customize variables for your environment
5. Run `terraform init`, `terraform plan`, and `terraform apply`

## 🤝 Contributing

When adding new modules:
- Follow the existing module structure
- Include comprehensive documentation in a README.md
- Provide working examples in `terraform/examples/`
- Follow security best practices
- Ensure `terraform validate` passes

## 📄 License

See [LICENSE](LICENSE) file for details.
