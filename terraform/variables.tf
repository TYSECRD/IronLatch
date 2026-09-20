variable "aws_region" {
  description = "AWS region for IronLatch resources."
  type        = string
  default     = "us-east-1"
}

variable "repository_name" {
  description = "ECR repository name."
  type        = string
  default     = "ironlatch"
}
