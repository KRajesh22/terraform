resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags {
    Name = "main"
  }
}

variable "availability_zones" {
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]  
}

variable "public_subnets"  {
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}


resource "aws_subnet" "public" {
  count             = "3"
  vpc_id            = "${aws_vpc.main.id}"
  availability_zone = "${element(var.availability_zones, count.index)}"
  cidr_block        = "${element(var.public_subnets, count.index)}"
}