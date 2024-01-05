#outputs of the rds main configuration file
output "rds_security_group_id" {
  value = "aws_db_instance.mysql_db_instance.id"
}

