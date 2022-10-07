module "irsa" {
  source = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"

  role_name             = "${var.uniqueName}_${var.release}_${var.chart}"
  attach_ebs_csi_policy = true

  oidc_providers = {
    main = {
      provider_arn               = var.eks_oidc_provider_arn
      namespace_service_accounts = ["${var.namespace}:${var.sa}"]
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}



resource "helm_release" "ebs_csi" {

  name             = var.release
  namespace        = var.namespace
  repository       = var.repository
  chart            = var.chart
  version          = var.chart_version
  create_namespace = false

  values = var.values

  set {
    name  = var.value_arn
    value = module.irsa.iam_role_arn
    type  = "string"
  }
}

