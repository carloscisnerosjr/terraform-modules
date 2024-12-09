data "aws_ssoadmin_instances" "example" {}

output "arn" {
  value = tolist(data.aws_ssoadmin_instances.example.arns)[0]
}

output "identity_store_id" {
  value = tolist(data.aws_ssoadmin_instances.example.identity_store_ids)[0]
}