resource "helm_release" "nginx-ingress" {
  name       = "nginx-ingress"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = "default"

  version = "4.0.16"

  verify        = false
  recreate_pods = true
  reset_values  = true
  force_update  = true
  wait          = true
  wait_for_jobs = true
  atomic        = true

  set {
    name  = "controller.metrics.service.clusterIP"
    value = cidrhost(cidrsubnets(var.networks.services, 1, 1)[1], 111)
  }

  set {
    name  = "controller.admissionWebhooks.service.clusterIP"
    value = cidrhost(cidrsubnets(var.networks.services, 1, 1)[1], 112)
  }

  set {
    name  = "controller.service.clusterIP"
    value = cidrhost(cidrsubnets(var.networks.services, 1, 1)[1], 113)
  }

  set {
    name  = "controller.electionID"
    value = "nginx"
  }

  set {
    name  = "controller.ingressClassResource.name"
    value = "nginx"
  }

  set {
    name  = "controller.extraArgs.ingress-class"
    value = "nginx"
  }

  set {
    name  = "controller.ingressClassResource.controllerValue"
    value = "k8s.io/ingress-nginx"
  }

  set {
    name  = "controller.metrics.enabled"
    value = "true"
  }
  set {
    name  = "controller.podAnnotations.prometheus\\.io/port"
    value = "10254"
    type  = "string"
  }

  set {
    name  = "controller.podAnnotations.prometheus\\.io/scrape"
    value = "true"
    type  = "string"
  }
}
