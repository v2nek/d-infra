resource "random_pet" "infra_id" {
  # this resource will generate random id that will be used across infrastructure to generate resource names
  separator = "-"
  length    = 2
}
