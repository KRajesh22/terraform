provider "aws" {
  region =  "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "terra-citb32"
    key    = "student-proj-test-env/terraform.state"
    region = "us-east-1"
  }
}

