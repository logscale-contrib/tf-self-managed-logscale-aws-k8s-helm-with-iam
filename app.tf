data "template_file" "app" {
  template = file("${path.module}/app.yaml")
  vars = {
    chart         = var.chart
    repository    = var.repository
    chart_version = var.chart_version
    release       = var.release
    value_arn     = value.value_arn
    iam_role_arn  = module.irsa.iam_role_arn
    values        = var.values
    namespace     = value.namespace
  }
}

resource "kubectl_manifest" "app" {
  yaml_body = data.template_file.app
}
