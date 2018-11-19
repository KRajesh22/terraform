variable "vpc-cidr" {
    default = "10.0.0.0/16"
}
resource "aws_vpc" "student-vpc" {
  cidr_block       = "${var.vpc-cidr}"
  instance_tenancy = "default"

  tags {
    Name = "Student-VPC"
  }
}

resource "aws_subnet" "public1" {
  vpc_id     = "${aws_vpc.student-vpc.id}"
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags {
    Name = "Public1"
  }
}

resource "aws_subnet" "public2" {
  vpc_id     = "${aws_vpc.student-vpc.id}"
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true

  tags {
    Name = "Public2"
  }
}

resource "aws_subnet" "private1" {
  vpc_id     = "${aws_vpc.student-vpc.id}"
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1a"

  tags {
    Name = "Private1"
  }
}

resource "aws_subnet" "private2" {
  vpc_id     = "${aws_vpc.student-vpc.id}"
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-east-1b"

  tags {
    Name = "Private2"
  }
}

resource "aws_internet_gateway" "student-igw" {
  vpc_id = "${aws_vpc.student-vpc.id}"

  tags {
    Name = "Student-IGW"
  }
}

resource "aws_route_table" "publicrtb" {
  vpc_id = "${aws_vpc.student-vpc.id}"

  tags {
    Name = "Public-RT"
  }
}

resource "aws_route" "publicrtb-igw" {
  route_table_id            = "${aws_route_table.publicrtb.id}"
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = "${aws_internet_gateway.student-igw.id}"
}

resource "aws_route_table" "privatertb" {
  vpc_id = "${aws_vpc.student-vpc.id}"

  tags {
    Name = "Private-RT"
  }
}

resource "aws_route_table_association" "pub1-rtb-assoc" {
  subnet_id      = "${aws_subnet.public1.id}"
  route_table_id = "${aws_route_table.publicrtb.id}"
}

resource "aws_route_table_association" "pub2-rtb-assoc" {
  subnet_id      = "${aws_subnet.public2.id}"
  route_table_id = "${aws_route_table.publicrtb.id}"
}

resource "aws_route_table_association" "priv1-rtb-assoc" {
  subnet_id      = "${aws_subnet.private1.id}"
  route_table_id = "${aws_route_table.privatertb.id}"
}

resource "aws_route_table_association" "priv2-rtb-assoc" {
  subnet_id      = "${aws_subnet.private2.id}"
  route_table_id = "${aws_route_table.privatertb.id}"
}


resource "aws_security_group" "ec2sg" {
  name        = "EC2-StudentApp-SG"
  description = "EC2 StudentApp Security Group"
  vpc_id      = "${aws_vpc.student-vpc.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags {
    Name = "EC2-StudentApp-SG"
  }
}

resource "aws_security_group" "rdssg" {
  name        = "RDS-StudentApp-SG"
  description = "RDS StudentApp Security Group"
  vpc_id      = "${aws_vpc.student-vpc.id}"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc-cidr}"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags {
    Name = "RDS-StudentApp-SG"
  }
}

resource "aws_db_subnet_group" "db-subnetgroup" {
  name       = "studentapp-rds-sg"
  subnet_ids = ["${aws_subnet.private1.id}", "${aws_subnet.private2.id}"]

  tags {
    Name = "Studentapp-Subnetgroup"
  }
}
