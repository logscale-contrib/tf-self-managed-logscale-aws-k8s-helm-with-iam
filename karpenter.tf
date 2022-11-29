resource "aws_iam_instance_profile" "karpenter" {
  count = var.attach_karpenter_controller_policy ? 1 : 0
  name  = "KarpenterNodeInstanceProfile-${var.uniqueName}"
  role  = var.eks_karpenter_iam_role_name
}

resource "kubectl_manifest" "karpenter_provisioners" {
  depends_on = [
    module.release,
    aws_iam_instance_profile.karpenter,
    kubectl_manifest.AWSNodeTemplate
  ]
  for_each  = var.karpenter_provisioners
  yaml_body = each.value
}

resource "kubectl_manifest" "AWSNodeTemplate" {
  count = var.attach_karpenter_controller_policy ? 1 : 0

  depends_on = [
    module.release
  ]
  yaml_body = <<YAML
apiVersion: karpenter.k8s.aws/v1alpha1
kind: AWSNodeTemplate
metadata:
  name: default
spec:
  subnetSelector:
    Name: "*public*"
    karpenter.sh/discovery/${var.uniqueName}: ${var.uniqueName}
  securityGroupSelector:
    karpenter.sh/discovery/${var.uniqueName}: ${var.uniqueName}
  tags:
    karpenter.sh/discovery/${var.uniqueName}: ${var.uniqueName}    
YAML
}
