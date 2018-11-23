variable "vpc_cidr" {}
variable "public_subnets" {
    type = "list"
}
variable "private_subnets" {
    type = "list"
}

variable "environment" {}
variable "proj-name" {
    default = "studentapp"
}

variable "dbname" {}
variable "dbuser" {}
variable "dbpass" {}

variable "keypairname" {}
