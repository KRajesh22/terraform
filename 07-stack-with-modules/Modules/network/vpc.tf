resource "aws_vpc" "vpc" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "default"

  tags {
    Name    = "${var.proj-name}-vpc-${var.environment}"
    Creator = "Terraform"
    Owner   = "CIT"
    Environment = "${var.environment}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name    = "${var.proj-name}-igw-${var.environment}"
    Creator = "Terraform"
    Owner   = "CIT"
    Environment = "${var.environment}"
  }
}