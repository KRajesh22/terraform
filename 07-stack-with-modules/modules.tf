module "network" {
  source  = "./Modules/network"
}

module "database" {
  source  = "./Modules/database"
}

module "infra" {
  source  = "./Modules/infra"
}