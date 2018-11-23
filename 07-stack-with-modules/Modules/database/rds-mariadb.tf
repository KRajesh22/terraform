resource "aws_db_instance" "mariadb" {
  identifier           = "${var.dbname}-rds"
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mariadb"
  engine_version       = "10.3.8"
  instance_class       = "db.t2.micro"
  name                 = "${var.dbname}"
  username             = "${var.dbuser}"
  password             = "${var.dbpass}"
  multi_az             = false
  db_subnet_group_name  = "${var.db-subnet-group}"
  vpc_security_group_ids  = ["${var.security-group}"]
  skip_final_snapshot   = true
}