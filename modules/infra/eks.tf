module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name                    = random_pet.infra_id.id
  cluster_version                 = "1.21"
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  cluster_addons = {
    coredns = {
      resolve_conflicts = "OVERWRITE"
    }
    kube-proxy = {}
    vpc-cni = {
      resolve_conflicts = "OVERWRITE"
    }
  }

  vpc_id                    = module.vpc.vpc_id
  subnet_ids                = module.vpc.private_subnets
  cluster_service_ipv4_cidr = local.networks.services

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    ami_type               = "BOTTLEROCKET_x86_64"
    platform               = "bottlerocket"
    disk_size              = 20
    instance_types         = ["t3.large"]
    vpc_security_group_ids = [module.internal_access.security_group_id, module.internet_access.security_group_id]
  }

  eks_managed_node_groups = {
    main = {
      min_size     = 3
      max_size     = 5
      desired_size = 3
    }
  }


  tags = merge(
    var.tags
  )
}
