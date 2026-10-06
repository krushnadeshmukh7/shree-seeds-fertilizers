module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 6.0"
  name = "shree-seeds-vpc"
  cidr = "10.0.0.0/16"
  azs = ["us-west-2a", "us-west-2b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]
  enable_nat_gateway = true
  single_nat_gateway = true
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = { Project = "Shree-Seeds-Fertilizers" }
}
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"
  name = var.cluster_name
  kubernetes_version = "1.33"
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
  endpoint_public_access = true
  enable_cluster_creator_admin_permissions = true
  eks_managed_node_groups = {
    shree_seeds_nodes = {
      name = "shree-seeds-nodes"
      instance_types = ["c7i-flex.large"]
      min_size = 2
      max_size = 2
      desired_size = 2
      capacity_type = "ON_DEMAND"
    }
  }
  tags = { Project = "Shree-Seeds-Fertilizers", Environment = "dev", ManagedBy = "Terraform" }
}
