resource "kubernetes_namespace" "ns" {
  count = var.attach_external_dns_policy ? 1 : 0
  metadata {
    name = var.namespace
  }
}

data "aws_route53_zone" "selected" {
  count = var.attach_external_dns_policy ? 1 : 0
  name         = var.domain_name
  private_zone = var.domain_is_private
}


locals {
  dns_arns = var.attach_external_dns_policy ? [data.aws_route53_zone.selected.arn] : []
}

module "irsa" {
  source = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"

  depends_on = [
    kubernetes_namespace.ns
  ]

  role_name                  = "${var.uniqueName}_${var.release}_${var.chart}"
  attach_ebs_csi_policy      = var.attach_ebs_csi_policy
  attach_external_dns_policy = var.attach_external_dns_policy
  external_dns_hosted_zone_arns = local.dns_arns

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



resource "helm_release" "chart" {

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

