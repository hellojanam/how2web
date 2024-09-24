provider "aws" {
  region = "eu-central-1"
  default_tags {
    tags = var.common_tags
  }
}  

module "vpc" {
  source              = "./modules/vpc"
  cluster_name        = var.cluster_name
  vpc_cidr            = var.vpc_cidr
  region_azs          = var.region_azs
  num_public_subnets  = var.num_public_subnets
  num_private_subnets = var.num_private_subnets
  project_name        = local.project_name
}

module "eks" {
  source            = "./modules/eks"
  cluster_name      = var.cluster_name
  cluster_version   = var.cluster_version
  private_subnets   = module.vpc.private_subnets
  vpc_id            = module.vpc.vpc_id
  eks_api_access    = [module.bastion.bastion_secgroup]
  project_name      = local.project_name
  argo_workflows_sa = "cicd:argo-workflow"
}

module "eks_general_nodes" {
  source          = "./modules/eks_node_group"
  cluster_name    = module.eks.cluster_name
  private_subnets = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id
  project_name    = local.project_name
  nodegroup_ami_type  = var.nodegroup_ami_type  
}

module "bastion" {
  source                = "./modules/ec2"
  bastion_subnet        = module.vpc.public_subnets[0] # eu-central-1a
  vpc_id                = module.vpc.vpc_id
  public_key            = var.public_key
  helmfile_version      = var.helmfile_version
  kubectl_version       = var.kubectl_version
  eks_cluster_arn       = module.eks.cluster_arn
  bastion_instance_type = var.bastion_instance_type
  project_name          = local.project_name 
}