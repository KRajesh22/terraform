variable "security-group"  {}
variable "keypairname" {}

variable "public-subnets" {
    type = "list"
}

variable "availability_zones" {
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]  
}

variable "proj-name" {}
