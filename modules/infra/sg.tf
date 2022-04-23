module "internet_access" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${random_pet.infra_id.id}-internet"
  description = "Security group with allowed ssh for specific ip addresses"
  vpc_id      = module.vpc.vpc_id

  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["all-all"]

  tags = merge(
    var.tags
  )
}

module "internal_access" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${random_pet.infra_id.id}-local"
  description = "Security group with allowed local traffic from VPC"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = [var.cidr]
  ingress_rules       = ["all-all"]

  egress_cidr_blocks = [var.cidr]
  egress_rules       = ["all-all"]

  tags = merge(
    var.tags
  )
}
