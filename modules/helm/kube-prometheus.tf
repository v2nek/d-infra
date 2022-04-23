resource "helm_release" "kube-prometheus" {
  name       = "kube-prometheus-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  namespace  = "default"

  version = "34.10.0"

  verify        = false
  recreate_pods = true
  reset_values  = true
  force_update  = true
  wait          = true
  wait_for_jobs = true
  atomic        = true
}
