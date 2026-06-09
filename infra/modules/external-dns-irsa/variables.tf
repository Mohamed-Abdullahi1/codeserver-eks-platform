variable "hosted_zone_id" {
  description = "Route 53 hosted zone ID ExternalDNS can manage"
  type        = string
}

variable "namespace" {
  description = "Kubernetes namespace for ExternalDNS"
  type        = string
  default     = "external-dns"
}

variable "service_account_name" {
  description = "Kubernetes service account name for ExternalDNS"
  type        = string
  default     = "external-dns"
}

variable "cluster_name" {
  description = "EKS cluster name for the Pod Identity association"
  type        = string
}