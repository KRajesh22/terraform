module "network" {
  source  = "./Modules/network"
  vpc_cidr = "${var.vpc_cidr}"
  public_subnets = "${var.public_subnets}"
  private_subnets = "${var.private_subnets}"
  environment = "${var.environment}"
  proj-name = "${var.proj-name}"
}

module "database" {
  source  = "./Modules/database"
}

module "infra" {
  source  = "./Modules/infra"
}