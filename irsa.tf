module "irsa" {
  source = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"

  role_name = "${var.uniqueName}_${var.namespace}_${var.sa}"

  attach_ebs_csi_policy = var.attach_ebs_csi_policy

  attach_external_dns_policy    = var.attach_external_dns_policy
  external_dns_hosted_zone_arns = local.dns_arns

  attach_cert_manager_policy    = var.attach_cert_manager_policy
  cert_manager_hosted_zone_arns = local.dns_arns

  attach_load_balancer_controller_policy = var.attach_load_balancer_controller_policy

  attach_karpenter_controller_policy = var.attach_karpenter_controller_policy

  karpenter_tag_key               = "karpenter.sh/discovery/${var.uniqueName}"
  karpenter_controller_cluster_id = var.eks_cluster_id
  karpenter_controller_node_iam_role_arns = [
    var.eks_karpenter_iam_role_arn
  ]


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



# resource "helm_release" "chart" {

#   name             = var.release
#   namespace        = var.namespace
#   repository       = var.repository
#   chart            = var.chart
#   version          = var.chart_version
#   create_namespace = var.create_namespace

#   values = var.values

#   set {
#     name  = var.value_arn
#     value = module.irsa.iam_role_arn
#     type  = "string"
#   }
# }

