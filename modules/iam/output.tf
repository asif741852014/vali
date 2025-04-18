output "instance_profile" {
  value = aws_iam_instance_profile.worker.name
}

output "masterrole" {
  value = aws_iam_role.master.arn
}

output "workerrole" {
  value = aws_iam_role.worker.arn
}

