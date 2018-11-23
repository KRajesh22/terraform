variable "vpcid" {}
resource "aws_subnet" "main" {
  vpc_id     = "${var.vpcid}"
  cidr_block = "10.20.1.0/24"

  tags {
    Name = "Main"
  }
}
