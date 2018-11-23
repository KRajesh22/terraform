resource "aws_db_subnet_group" "db-subnet-group" {
  name       = "db-subnet-group"
  subnet_ids = ["${aws_subnet.private-subnets.*.id}"]

  tags {
    Name = "${var.proj-name}-${var.environment}-private-db-subnet-group"
    Creator = "Terraform"
    Owner   = "CIT"
    Environment = "${var.environment}"
  }
}