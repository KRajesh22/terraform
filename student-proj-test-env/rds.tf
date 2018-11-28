resource "aws_db_instance" "default" {
  allocated_storage    = 10
  storage_type         = "gp2"
  engine               = "mariadb"
  engine_version       = "10.3"
  instance_class       = "db.t2.micro"
  name                 = "studentapp"
  username             = "student"
  password             = "student1"
}

resource "null_resource" "dbschema" {
  depends_on = ["aws_db_instance.default"]
  provisioner "local-exec" {
    command = <<EOF
    curl -s https://raw.githubusercontent.com/citb32/project-setup/master/studentapp-table.sql >/tmp/schema
    mysql -h ${aws_db_instance.default.address} -u student -pstudent1 </tmp/schema
    EOF
  }
}
