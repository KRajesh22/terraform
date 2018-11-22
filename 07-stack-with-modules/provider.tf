provider "aws" {}

terraform {
  backend "s3" {
    bucket = "terra-citb32"
    key    = "07-stack-with-modules/DEV/terraform.state"
    region = "us-east-1"
  }
}
