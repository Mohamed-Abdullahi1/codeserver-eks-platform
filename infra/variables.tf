variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "availability_zones" {
  description = "Availability zones used by the platform"
  type        = list(string)
  default     = ["eu-west-2a", "eu-west-2b"]
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
  default     = "codeserver.moabdullahi.uk"
}

variable "local_admin_arn" {
  description = "IAM ARN for local kubectl admin access"
  type        = string
}

variable "github_actions_role_arn" {
  description = "IAM role ARN used by GitHub Actions for EKS access"
  type        = string
}