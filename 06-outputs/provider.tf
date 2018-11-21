provider "aws" {} 

terraform {
  backend "s3" {
    bucket = "terra-citb32"
    key    = "terraform-remote-state/terraform.state"
    region = "us-east-1"
  }
}


resource "aws_s3_bucket" "b" {
  bucket = "terra-citb32-test-bucket"
  acl    = "private"

  tags {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

output "arn-of-bucket" {
  value = "${aws_s3_bucket.b.arn}"
}
