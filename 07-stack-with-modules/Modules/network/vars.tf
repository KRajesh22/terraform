variable "vpc_cidr" {}
variable "public_subnets" {
    type = "list"
}
variable "private_subnets" {
    type = "list"
}

variable "availability_zones" {
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]  
}

variable "environment" {}
variable "proj-name" {}