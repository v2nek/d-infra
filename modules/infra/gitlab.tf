resource "gitlab_project_variable" "kubeconfig" {
  project = var.gitlab_project_id
  key     = "KUBECONFIG_FILE"
  value = templatefile(
    "${path.module}/templates/kubeconfig.tftpl",
    {
      NAME       = random_pet.infra_id.id,
      SERVER_URL = module.eks.cluster_endpoint,
      CA_DATA    = module.eks.cluster_certificate_authority_data,
      # funniest part
      TOKEN = data.kubernetes_secret_v1.deploy_account_secret.data["token"]
      #   TOKEN = ""
    }
  )
  variable_type = "file"

  depends_on = [
    module.base-k8s
  ]
}

resource "gitlab_deploy_token" "deploy" {
  project  = var.gitlab_project_id
  name     = random_pet.infra_id.id
  username = random_pet.infra_id.id

  scopes = ["read_registry", "write_registry"]
}

data "kubernetes_secret_v1" "deploy_account_secret" {
  metadata {
    name      = module.base-k8s.deploy_account_secret
    namespace = "kube-system"
  }
}

resource "gitlab_project_variable" "dockerauthconfig" {
  project = var.gitlab_project_id
  key     = "DOCKER_AUTH_CONFIG"
  value = templatefile(
    "${path.module}/templates/dockercfg.tftpl",
    {
      AUTH = base64encode("${random_pet.infra_id.id}:${gitlab_deploy_token.deploy.token}")
    }
  )

  depends_on = [
    module.base-k8s
  ]
}
