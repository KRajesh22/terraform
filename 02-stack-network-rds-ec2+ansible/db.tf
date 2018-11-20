variable "dbuser" {
    default = "student"
}

variable "dbpass" {
    default = "student1"
}

resource "null_resource" "dbschema" {
  depends_on = ["aws_db_instance.default"]
  provisioner "local-exec" {
    command = <<EOF
    curl -s https://raw.githubusercontent.com/citb32/project-setup/master/student-app-schema.sql >/tmp/schema
    mysql -h ${aws_db_instance.default.address} -u ${var.dbuser} -p${var.dbpass} </tmp/schema
    EOF
  }
}

resource "aws_db_instance" "default" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "studentapp"
  username             = "${var.dbuser}"
  password             = "${var.dbpass}"
  parameter_group_name = "default.mysql5.7"
}