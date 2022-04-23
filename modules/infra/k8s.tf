module "base-k8s" {
  source = "../base-k8s"
}

module "helm" {
  source = "../helm"

  networks = local.networks
}
