resource "aws_ecr_repository" "ironlatch" {
  name                 = var.repository_name
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = {
    Environment = "portfolio"
  }
}

data "aws_iam_policy_document" "ci_ecr" {
  statement {
    sid    = "ECRAuthentication"
    effect = "Allow"

    actions = [
      "ecr:GetAuthorizationToken"
    ]

    resources = ["*"]
  }

  statement {
    sid    = "IronLatchRepositoryAccess"
    effect = "Allow"

    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:CompleteLayerUpload",
      "ecr:DescribeImages",
      "ecr:DescribeRepositories",
      "ecr:GetDownloadUrlForLayer",
      "ecr:InitiateLayerUpload",
      "ecr:ListImages",
      "ecr:PutImage",
      "ecr:UploadLayerPart"
    ]

    resources = [
      aws_ecr_repository.ironlatch.arn
    ]
  }
}

resource "aws_iam_policy" "ci_ecr" {
  name        = "${var.repository_name}-ci-ecr"
  description = "Least-privilege ECR access for the IronLatch CI pipeline."
  policy      = data.aws_iam_policy_document.ci_ecr.json
}
