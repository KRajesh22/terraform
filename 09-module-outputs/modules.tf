module "vpc" {
  source = "./vpc"
}

module "subnet" {
  source = "./subnet"
  vpcid = "${module.vpc.vpcid}"
}
