data "aws_route53_zone" "selected" {
  count        = var.attach_external_dns_policy ? 1 : 0
  name         = var.domain_name
  private_zone = var.domain_is_private
}


locals {
  dns_arns = var.attach_external_dns_policy ? [data.aws_route53_zone.selected[0].arn] : []
}
