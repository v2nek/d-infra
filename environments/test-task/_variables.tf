variable "aws_region" {
  description = "AWS region to use"
  default     = "us-east-2"
}

variable "gitlab_token" {
  description = "GitLab token to access installation"
}

# here is consideration of small half-hand-managed task 
# that will be rolled out in a small less automated environment
# other way this would declare other configuration for deployment
variable "gitlab_project_id" {
  description = "Project ID where to create environment variables for deployment, project must exist"
}

variable "gitlab_user" {
  description = "gitlab user that is used to work with gitlab"
}
