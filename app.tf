resource "kubectl_manifest" "app" {
  yaml_body = templatefile(
    "${path.module}/app.tfpl.yaml",
    { chart         = var.chart
      repository    = var.repository
      chart_version = var.chart_version
      release       = var.release
      value_arn     = var.value_arn
      iam_role_arn  = module.irsa.iam_role_arn
      values        = var.values
  namespace = var.namespace })
}
