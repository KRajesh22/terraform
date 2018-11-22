resource "aws_subnet" "public-subnets" {
  count             = "3"
  vpc_id            = "${aws_vpc.vpc.id}"
  availability_zone = "${element(var.availability_zones, count.index)}"
  cidr_block        = "${element(var.public_subnets, count.index)}"
  tags {
    Name    = "${var.proj-name}-${var.environment}-subnet-public-${count.index}"
    Creator = "Terraform"
    Owner   = "CIT"
    Environment = "${var.environment}"
  }
}

resource "aws_subnet" "private-subnets" {
  count             = "3"
  vpc_id            = "${aws_vpc.vpc.id}"
  availability_zone = "${element(var.availability_zones, count.index)}"
  cidr_block        = "${element(var.private_subnets, count.index)}"
  tags {
    Name    = "${var.proj-name}-${var.environment}-subnet-private-${count.index}"
    Creator = "Terraform"
    Owner   = "CIT"
    Environment = "${var.environment}"
  }
}