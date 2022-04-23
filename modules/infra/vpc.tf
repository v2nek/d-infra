module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = random_pet.infra_id.id
  cidr = var.cidr

  azs              = local.azs
  private_subnets  = local.networks.private
  public_subnets   = local.networks.public
  database_subnets = local.networks.database

  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  create_database_subnet_group           = true
  create_database_subnet_route_table     = true
  create_database_internet_gateway_route = true

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(
    var.tags
  )
}
