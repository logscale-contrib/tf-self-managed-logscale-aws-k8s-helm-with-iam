data "aws_route53_zone" "selected" {
  count        = var.attach_external_dns_policy || var.attach_cert_manager_policy ? 1 : 0
  zone_id         = var.zone_id
}


locals {
  dns_arns = var.attach_external_dns_policy || var.attach_cert_manager_policy ? [data.aws_route53_zone.selected[0].arn] : []
}
