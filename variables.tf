variable "uniqueName" {
  type        = string
  description = "(optional) describe your variable"
}
variable "eks_cluster_id" {
  type        = string
  description = "(optional) describe your variable"
}
variable "eks_endpoint" {
  type        = string
  description = "(optional) describe your variable"
}
variable "eks_cluster_certificate_authority_data" {
  type        = string
  description = "(optional) describe your variable"
}
variable "eks_oidc_provider_arn" {
  type        = string
  description = "(optional) describe your variable"
}

variable "repository" {
  type        = string
  description = "(optional) describe your variable"
}

variable "release" {
  type        = string
  description = "(optional) describe your variable"
}

variable "chart" {
}

variable "chart_version" {

}

variable "namespace" {
  type        = string
  description = "(optional) describe your variable"
}

variable "create_namespace" {
  type    = bool
  default = false
}

variable "sa" {

}

variable "values" {
  # type = map(any)
}

variable "value_arn" {

}


variable "attach_ebs_csi_policy" {
  type    = bool
  default = false
}

variable "attach_external_dns_policy" {
  type    = bool
  default = false
}


variable "zone_id" {
  type    = string
  default = ""
}

variable "attach_cert_manager_policy" {
  type    = bool
  default = false
}
variable "attach_load_balancer_controller_policy" {
  type    = bool
  default = false

}

variable "project" {
  type    = string
  default = "default"
}
