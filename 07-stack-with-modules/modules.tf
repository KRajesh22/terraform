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
  dbname = "${var.dbname}"
  dbuser = "${var.dbuser}"
  dbpass = "${var.dbpass}"
  db-subnet-group = "${module.network.db-subnet-group}"
  security-group  = "${module.network.security-group}"
}

module "infra" {
  source  = "./Modules/infra"
  security-group  = "${module.network.security-group}"
  keypairname   = "${var.keypairname}"
  public-subnets  = ["${module.network.public-subnets}"]
  proj-name = "${var.proj-name}"
  security-group  = "${module.network.security-group}"
}