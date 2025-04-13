# Conexión directa al cluster EKS

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "Stack-Grafana" {
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = "70.4.2"

  namespace         = "curso-monitoreo"
  create_namespace  = true

  values = [
    file("${path.module}/charts/monitoreo/monitoreo-values.yaml")
  ]

depends_on = [module.eks]

}
