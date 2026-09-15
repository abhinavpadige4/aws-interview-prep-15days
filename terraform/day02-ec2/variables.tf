variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Name of the EC2 key pair"
  type        = string
  default     = "aws-interview-key"
}

variable "instance_name" {
  description = "Name tag for the EC2 instance"
  type        = string
  default     = "aws-interview-ec2-terraform"
}