//AWS ROLE DEFINITION TO SET IN A RESOURCE

// INTANCE PROFILE ---- to set a role
resource "aws_iam_instance_profile" "iam_profile" {
  name = "${var.environment}-tf-profile"
  role = aws_iam_role.role.name
  tags = var.myTags
}

//role to set in Intance Profile
resource "aws_iam_role" "role" {
  name               = "${var.environment}-tf-role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  tags               = var.myTags
}

//JSON configuraton to allow full access to EC2
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]

  }

  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["elasticfilesystem.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }

  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["route53.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }

}
