provider "aws" {
  region = var.region
}

module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  region   = var.region
}

module "compute" {
  source             = "./modules/compute"
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  lb_sg_id           = module.vpc.lb_sg_id
  instance_sg_id     = module.vpc.instance_sg_id
}
