provider "aws" {
  region = var.aws_region
}

provider "gitlab" {
  token = var.gitlab_token
}

