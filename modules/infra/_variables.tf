variable "cidr" {
  description = "CIDR string for the infrastructure"
  type        = string
}

variable "tags" {
  description = "Global tags applied to all resources"
  type        = map(string)
  default     = {}
}

variable "aws_region" {
  description = "AWS region where to roll everything"
}

variable "gitlab_project_id" {
  description = "gitlab project to use for setting up deployment secrets"
}

variable "gitlab_token" {
  description = "gitlab token used to authenticate here and there"
}

variable "gitlab_user" {
  description = "gitlab user that is used to work with gitlab"
}
