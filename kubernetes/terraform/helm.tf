# provider "helm" {
#   kubernetes {
#     host                   = data.aws_eks_cluster.cluster.endpoint
#     cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
#     token                  = data.aws_eks_cluster_auth.eks.token
# 
#     load_config_file       = false
#   }
# }

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
