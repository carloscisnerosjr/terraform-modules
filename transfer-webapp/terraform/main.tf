resource "aws_identitystore_user" "example" {
  identity_store_id = data.aws_ssoadmin_instances.example.identity_store_ids[0]

  display_name = "John Doe"
  user_name    = "johndoe"

  name {
    given_name  = "John"
    family_name = "Doe"
  }

  emails {
    value = "john@example.com"
  }
}

resource "aws_s3control_access_grants_instance" "example" {
    identity_center_arn = data.aws_ssoadmin_instances.example.arns[0]
}

resource "aws_s3control_access_grants_location" "example" {
  depends_on = [aws_s3control_access_grants_instance.example]

  iam_role_arn   = aws_iam_role.access_grant_role.arn
  location_scope = "s3://fantastic-guacamole-certs/*"
}

resource "aws_s3control_access_grant" "example" {
  access_grants_location_id = aws_s3control_access_grants_location.example.access_grants_location_id
  permission                = "READWRITE"

  grantee {
    grantee_type       = "DIRECTORY_USER"
    grantee_identifier = aws_identitystore_user.example.user_id
  }
}