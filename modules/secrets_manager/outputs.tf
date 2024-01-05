#outputs of the aws secret manager
output "aws_secretsmanager_secret_rds_secret_id" {
  value = aws_secretsmanager_secret.rds_secret.id
}

output "rds_secret_string" {
  value = aws_secretsmanager_secret.rds_secret.secret_string
}