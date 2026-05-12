variable "vpc_cidr" {
  type = string
}

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "private_subnet_cidrs" {
  type = list(string)
}

variable "availability_zones" {
  type = list(string)
}

variable "argocd_namespace" {
  description = "Namespace where ArgoCD will be installed"
  type        = string
  default     = "argocd"
}

variable "argocd_chart_version" {
  description = "Version of the ArgoCD Helm chart"
  type        = string
  default     = "7.7.0"
}

variable "domain_name" {
  description = "Root domain for Route 53 hosted zone"
  type        = string
}

variable "local_admin_arn" {
  description = "IAM ARN for local kubectl admin access"
  type        = string
}