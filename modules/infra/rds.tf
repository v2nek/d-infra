locals {
  rds_allowed_security_groups = [module.internal_access.security_group_id]
}


resource "aws_kms_key" "rds" {
  description             = "${random_pet.infra_id.id}-rds"
  deletion_window_in_days = 10

  tags = merge(
    var.tags
  )
}

resource "aws_db_parameter_group" "rds-psql-aurora" {
  name_prefix = "${random_pet.infra_id.id}-aurora"
  family      = "aurora-postgresql13"
  description = "${random_pet.infra_id.id}-aurora"

  tags = merge(
    var.tags
  )
}

resource "aws_rds_cluster_parameter_group" "rds-psql-aurora" {
  name_prefix = "${random_pet.infra_id.id}-aurora"
  family      = "aurora-postgresql13"
  description = "${random_pet.infra_id.id}-aurora"

  tags = merge(
    var.tags
  )
}

module "rds-psql-aurora" {
  source = "terraform-aws-modules/rds-aurora/aws"

  name           = random_pet.infra_id.id
  engine         = "aurora-postgresql"
  engine_version = "13.4"
  instance_class = "db.t4g.medium"

  deletion_protection    = false
  create_db_subnet_group = false

  instances = {
    one = {}
  }

  vpc_id               = module.vpc.vpc_id
  subnets              = module.vpc.database_subnets
  db_subnet_group_name = random_pet.infra_id.id

  allowed_security_groups = local.rds_allowed_security_groups
  allowed_cidr_blocks     = ["172.31.0.0/16", "10.0.0.0/8"]

  master_username        = "administrator"
  create_random_password = true
  database_name          = "database_name"

  kms_key_id = aws_kms_key.rds.arn

  storage_encrypted   = true
  apply_immediately   = true
  monitoring_interval = 10

  preferred_maintenance_window = "Mon:00:00-Mon:03:00"
  preferred_backup_window      = "04:00-07:00"

  db_parameter_group_name         = aws_db_parameter_group.rds-psql-aurora.id
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.rds-psql-aurora.id

  enabled_cloudwatch_logs_exports = ["postgresql"]

  copy_tags_to_snapshot = true

  tags = merge(
    var.tags
  )
}
