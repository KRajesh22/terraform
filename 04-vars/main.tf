resource "aws_instance" "node2" {
  count         = "${var.count}"
  ami           = "ami-094161bf15ab55a9c"
  instance_type = "${var.instance_type}"
  subnet_id     = "subnet-f16d73dd"
  vpc_security_group_ids = ["sg-03ddf7ff47cdc900a"]
  key_name  = "devops"
  tags {
    Name = "Node2"
  }
}

