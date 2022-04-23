module "test-task" {
  source = "../../modules/infra"

  aws_region = var.aws_region
  cidr       = "10.142.0.0/16"

  gitlab_project_id = var.gitlab_project_id
  gitlab_token      = var.gitlab_token
  gitlab_user       = var.gitlab_user

  tags = local.shared_tags
}
