terraform {
  required_providers {
    aws={
      source = "hashicorp/aws"
    }
  }
}
provider "aws" {
  region="us-east-1"
  profile = "Cloud-DevSecops-user"
  shared_credentials_files = ["C:/Users/User/.aws/credentials"]
}