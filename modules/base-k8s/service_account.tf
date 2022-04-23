resource "kubernetes_cluster_role_binding_v1" "deploy_user" {
  metadata {
    name = "deploy"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "deploy"
    namespace = "kube-system"
  }
}

resource "kubernetes_service_account_v1" "deploy_user" {
  metadata {
    name      = "deploy"
    namespace = "kube-system"
  }
}
