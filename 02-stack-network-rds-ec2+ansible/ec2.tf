resource "aws_instance" "node1" {
  ami           = "ami-094161bf15ab55a9c"
  instance_type = "t2.micro"
  subnet_id     = "${aws_subnet.public1.id}"
  vpc_security_group_ids = ["${aws_security_group.ec2sg.id}"]
  key_name  = "devops"
  tags {
    Name = "Node1"
  }
}

resource "aws_instance" "node2" {
  ami           = "ami-094161bf15ab55a9c"
  instance_type = "t2.micro"
  subnet_id     = "${aws_subnet.public2.id}"
  vpc_security_group_ids = ["${aws_security_group.ec2sg.id}"]
  key_name  = "devops"
  tags {
    Name = "Node2"
  }
}