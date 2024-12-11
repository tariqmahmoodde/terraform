# Configure the provider
provider "aws" {
  region = "us-east-1"
}

# Terraform backend configuration
terraform {
  backend "s3" {
    bucket         = "terra1990" # Replace with your bucket name
    key            = "security-group/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"        # Replace with your table name
    encrypt        = true
  }
}

# Create a security group
resource "aws_security_group" "example" {
  name        = "${terraform.workspace}-terra-security-group"
  description = "Terraform security group"
  vpc_id      = var.vpc_id

  # Ingress rules
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Egress rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "example-security-group"
  }
}

# Output the security group ID
output "security_group_id" {
  value = aws_security_group.example.id
}