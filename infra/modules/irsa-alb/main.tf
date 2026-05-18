data "aws_iam_policy_document" "alb_controller_trust" {
  statement {
    effect = "Allow"

    principals {
      type        = "Federated"
      identifiers = [var.oidc_provider_arn]
    }

    actions = ["sts:AssumeRoleWithWebIdentity"]

    condition {
      test     = "StringEquals"
      variable = "${var.oidc_provider_url}:sub"

      values = [
        "system:serviceaccount:kube-system:aws-load-balancer-controller"
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "${var.oidc_provider_url}:aud"

      values = [
        "sts.amazonaws.com"
      ]
    }
  }
}

resource "aws_iam_role" "alb_controller" {
  name = "aws-load-balancer-controller-role"

  assume_role_policy = data.aws_iam_policy_document.alb_controller_trust.json
}

resource "aws_iam_policy" "alb_controller" {
  name = "AWSLoadBalancerControllerIAMPolicy"

  policy = file("${path.module}/iam-policy.json")
}

resource "aws_iam_role_policy_attachment" "alb_controller" {
  role       = aws_iam_role.alb_controller.name
  policy_arn = aws_iam_policy.alb_controller.arn
}

