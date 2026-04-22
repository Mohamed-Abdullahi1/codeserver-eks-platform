module "vpc" {
  source = "./modules/vpc"

  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

module "eks" {

  source = "./modules/eks"

  cluster_name = "codeserver-cluster"

  kubernetes_version = "1.32"

  private_subnet_ids = module.vpc.private_subnet_ids

  desired_size = 2

  min_size = 1

  max_size = 3

  instance_types = ["t3.medium"]

}