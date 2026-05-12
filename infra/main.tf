module "vpc" {
  source = "./modules/vpc"

  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

module "eks" {
  source = "./modules/eks"

  cluster_name       = "codeserver-cluster"
  kubernetes_version = "1.32"
  private_subnet_ids = module.vpc.private_subnet_ids

  desired_size   = 2
  min_size       = 1
  max_size       = 3
  instance_types = ["t3.medium"]

  local_admin_arn = var.local_admin_arn
  github_actions_role_arn = var.github_actions_role_arn
}

module "route53" {
  source      = "./modules/route53"
  domain_name = var.domain_name
}

module "external_dns_irsa" {
  source = "./modules/external-dns-irsa"

  oidc_provider_arn = module.eks.oidc_provider_arn
  oidc_provider_url = module.eks.oidc_provider_url
  hosted_zone_id    = module.route53.zone_id
}

module "eks_ebs_csi" {
  source = "./modules/eks-ebs-csi"

  cluster_name      = module.eks.cluster_name
  oidc_provider_arn = module.eks.oidc_provider_arn
  oidc_provider_url = module.eks.oidc_provider_url
}