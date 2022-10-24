module "release" {
  source  = "terraform-module/release/helm"
  version = "2.8.0"

  namespace        = var.namespace
  repository       = var.repository
  create_namespace = var.create_namespace

  app = {
    name    = var.release
    version = var.chart_version
    chart   = var.chart
    wait    = true
    deploy  = 1
  }

  values = var.values
  set = concat(var.set, [
    {
      "name"  = var.value_arn
      "value" = module.irsa.iam_role_arn
    }
  ])
}


