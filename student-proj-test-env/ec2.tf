resource "aws_instance" "web" {
  depends_on                = ["null_resource.dbschema"]
  ami                       = "ami-094161bf15ab55a9c"
  instance_type             = "t2.micro"
  key_name                  = "devops"
  vpc_security_group_ids    =  ["sg-03ddf7ff47cdc900a"]
  subnet_id                 = "subnet-f16d73dd"
  tags {
    Name = "Test-Env-Node"
  }
  user_data = <<-EOF
  #!/bin/bash
  sudo yum install ansible git -y
  sudo ansible-pull -U https://github.com/citb32/ansible-pull.git webapp.yml -e DBUSER=${var.dbuser} -e DBPASS=${var.dbpass} -e DBNAME=${var.dbname} -e DBIP=${aws_db_instance.default.address}
  EOF

}