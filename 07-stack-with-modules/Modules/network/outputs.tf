output "db-subnet-group" {
    value = "${aws_db_subnet_group.db-subnet-group.id}"
}

output "security-group" {
    value = "${aws_security_group.public-sg-ec2.id}"
}

output "public-subnets" {
    value = "${aws_subnet.public-subnets.*.id}"
}