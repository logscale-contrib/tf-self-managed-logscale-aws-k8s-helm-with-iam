resource "aws_iam_instance_profile" "karpenter" {
  count = var.attach_karpenter_controller_policy ? 1 : 0
  name  = "KarpenterNodeInstanceProfile-${var.uniqueName}"
  role  = var.eks_karpenter_iam_role_name
}

resource "kubectl_manifest" "karpenter_provisioners" {
  depends_on = [
    module.release
  ]
  #count     = var.attach_karpenter_controller_policy ? 1 : 0
  for_each  = var.karpenter_provisioners
  yaml_body = each.value
}
