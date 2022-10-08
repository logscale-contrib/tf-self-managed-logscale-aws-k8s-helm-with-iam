locals {
  values = yamlencode(var.values)
}
resource "kubectl_manifest" "app" {
  #   yaml_body = templatefile(
  #     "${path.module}/app.tfpl.yaml",
  #     { chart         = var.chart
  #       repository    = var.repository
  #       chart_version = var.chart_version
  #       release       = var.release
  #       value_arn     = var.value_arn
  #       iam_role_arn  = module.irsa.iam_role_arn
  #       values        = var.values
  #   namespace = var.namespace })
  yaml_body = <<YAML
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: ${var.chart}
  namespace: argocd
  # Add this finalizer ONLY if you want these to cascade delete.
  finalizers:
    - resources-finalizer.argocd.argoproj.io
spec:
  # The project the application belongs to.
  # resource "helm_release" "chart" {

  #   name             = release
  #   version          =
  #   create_namespace = create_namespace

  project: default
  source:
    chart: ${var.chart}
    repoURL: ${var.repository}
    targetRevision: ${var.chart_version}
    helm:
      releaseName: ${var.release}
      parameters:
        - name: ${var.value_arn}
          value: ${module.irsa.iam_role_arn}
      values: ${local.values}
  destination:
    namespace: ${var.namespace}
  syncPolicy:
    syncOptions:
      - CreateNamespace=${var.create_namespace}
YAML
}
