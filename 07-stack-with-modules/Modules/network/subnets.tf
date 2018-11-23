resource "aws_subnet" "public-subnets" {
  count             = "${length(var.availability_zones)}"
  vpc_id            = "${aws_vpc.vpc.id}"
  availability_zone = "${element(var.availability_zones, count.index)}"
  cidr_block        = "${element(var.public_subnets, count.index)}"
  tags {
    Name    = "${var.proj-name}-${var.environment}-subnet-public-${count.index+1}"
    Creator = "Terraform"
    Owner   = "CIT"
    Environment = "${var.environment}"
  }
}

resource "aws_subnet" "private-subnets" {
  count             = "${length(var.availability_zones)}"
  vpc_id            = "${aws_vpc.vpc.id}"
  availability_zone = "${element(var.availability_zones, count.index)}"
  cidr_block        = "${element(var.private_subnets, count.index)}"
  tags {
    Name    = "${var.proj-name}-${var.environment}-subnet-private-${count.index+1}"
    Creator = "Terraform"
    Owner   = "CIT"
    Environment = "${var.environment}"
  }
}

resource "aws_route_table" "r" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags {
    Name = "${var.proj-name}-${var.environment}-public-rt"
    Creator = "Terraform"
    Owner   = "CIT"
    Environment = "${var.environment}"
  }
}

resource "aws_route_table_association" "public-rt-assoc" {
  count             = "${length(var.availability_zones)}"
  subnet_id         = "${element(aws_subnet.public-subnets.*.id, count.index)}"
  route_table_id    = "${aws_route_table.r.id}"
}

