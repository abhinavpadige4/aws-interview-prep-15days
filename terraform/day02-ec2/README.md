# Day 2: EC2 Fundamentals - Terraform Implementation

This directory contains Terraform code to provision an EC2 instance with:
- Amazon Linux 2 AMI
- t2.micro instance type
- Security group allowing SSH (22) and HTTP (80)
- User data script to install Apache and deploy a simple HTML page
- Associated with default VPC and subnet

## Files in this directory
- `main.tf` - Main Terraform configuration
- `variables.tf` - Input variables
- `outputs.tf` - Output values (if needed)
- `README.md` - This file

## Prerequisites
- Terraform installed (v1.0.0+)
- AWS CLI configured with appropriate credentials
- AWS account with permissions to create EC2 instances, security groups, etc.

## Usage

### 1. Initialize Terraform
```bash
terraform init
```

### 2. Review the plan
```bash
terraform plan
```

### 3. Apply the configuration
```bash
terraform apply
```

Confirm the action when prompted.

### 4. Access the instance
After successful deployment, you'll see outputs including:
- Instance ID
- Public IP address
- Private IP address
- Security group ID

Connect via SSH:
```bash
ssh -i aws-interview-key.pem ec2-user@<PUBLIC_IP>
```

Note: You'll need to create the key pair separately or modify the Terraform to create it.

### 5. Destroy resources
When finished, to avoid charges:
```bash
terraform destroy
```

## Resources Created
- **EC2 Instance**: t2.micro running Amazon Linux 2
- **Security Group**: Allows SSH (22) and HTTP (80) from anywhere
- **Network Interface**: Automatically created in default subnet
- **Key Pair**: Referenced (must be created separately)

## Outputs
After `terraform apply`, you'll get:
- `instance_id`: The EC2 instance ID
- `instance_public_ip`: Public IP for SSH/web access
- `instance_private_ip`: Private IP within VPC
- `security_group_id`: ID of the created security group
- `key_pair_name`: Name of the referenced key pair

## User Data Script
The instance uses user data to automatically:
1. Update system packages
2. Install Apache HTTP server
3. Start and enable Apache service
4. Deploy a simple HTML welcome page showing the instance ID

## Cleanup
Remember to destroy resources when done to avoid ongoing charges:
```bash
terraform destroy
```

## Learning Objectives
- Understand Terraform AWS provider basics
- Learn EC2 resource configuration
- Practice security group creation
- Work with user data scripts
- Understand Terraform state management
- Practice infrastructure as code principles

## References
- [Terraform AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS EC2 Instance Resource](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)
- [AWS Security Group Resource](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)