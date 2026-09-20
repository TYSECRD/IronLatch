output "repository_url" {
  description = "IronLatch ECR repository URL."
  value       = aws_ecr_repository.ironlatch.repository_url
}

output "ci_policy_arn" {
  description = "IAM policy ARN for IronLatch CI."
  value       = aws_iam_policy.ci_ecr.arn
}
