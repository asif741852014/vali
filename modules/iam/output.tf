output "masterrole" {
  value = aws_iam_role.master.arn
}

output "workerrole" {
  value = aws_iam_role.worker.arn
}

