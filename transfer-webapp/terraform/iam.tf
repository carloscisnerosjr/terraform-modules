resource "aws_iam_role" "identity_bearer_role" {
  name = "identity-bearer-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = ["sts:AssumeRole", "sts:SetContext"]
        Effect = "Allow"
        Principal = {
          Service = "transfer.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "identity_bearer_policy" {
  name = "allow-s3-access-grants"
  role = aws_iam_role.identity_bearer_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = ["s3:GetDataAccess", "s3:ListCallerAccessGrants", "s3:ListAccessGrantsInstances"]
        Effect = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role" "access_grant_role" {
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = ["sts:AssumeRole", "sts:SetContext"]
        Effect = "Allow"
        Principal = {
          Service = "access-grants.s3.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "access_grant_policy" {
  name = "allow-s3-access-grants"
  role = aws_iam_role.access_grant_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = ["s3:*"]
        Effect = "Allow"
        Resource = "*"
      }
    ]
  })
}
