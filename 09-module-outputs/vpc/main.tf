resource "aws_vpc" "main" {
  cidr_block       = "10.20.0.0/16"
  instance_tenancy = "default"

  tags {
    Name = "main"
  }
}

output "vpcid" {
  value = "${aws_vpc.main.id}"
}
