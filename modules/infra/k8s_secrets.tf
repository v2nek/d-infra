resource "kubernetes_secret_v1" "dockerpull" {
  metadata {
    name = "registry-credentials"
  }

  data = {
    ".dockerconfigjson" = templatefile(
      "${path.module}/templates/dockercfg.tftpl",
      {
        AUTH = base64encode("${random_pet.infra_id.id}:${gitlab_deploy_token.deploy.token}")
      }
    )
  }

  type = "kubernetes.io/dockerconfigjson"
}

# resource "kubernetes_secret_v1" "settings" {
#   metadata {
#     name = "settings"
#   }

#   data = {
#     DATABASE = ""
#   }

# }
