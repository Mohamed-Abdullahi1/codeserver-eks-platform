output "role_arn" {
  description = "ARN of the IAM role used by ExternalDNS"
  value       = aws_iam_role.external_dns.arn
}