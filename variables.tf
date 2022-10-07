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
  type = list(string)

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


variable "domain_name" {
  type = string
  default = ""
}

variable "domain_is_private" {
  type = bool
  default = false
  description = "(optional) describe your variable"
}
variable "attach_cert_manager_policy" {
  type    = bool
  default = false
}