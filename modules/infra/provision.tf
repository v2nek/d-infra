# this file collects resources that require provisioning and 
# distributed into separate steps to ease initial provisioning

resource "null_resource" "step_1" {
  depends_on = [
    module.eks,
    module.vpc,
  ]
}

resource "null_resource" "step_2" {
  depends_on = [
    module.base-k8s,
    gitlab_project_variable.kubeconfig
  ]
}
