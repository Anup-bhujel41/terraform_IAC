#main configuration of the RDS instance

resource "aws_db_instance" "mysql_db_instance" {
  identifier                        = "mysql database instance"
  allocated_storage                 = 8 
  storage_type                      = "gp2"
  engine                            = "mysql"
  engine_version                    = "5.7"
  instance_class                    = "t2.micro"
  username                          = "admin"
  manage_master_user_password       = true
  #password                         = jsondecode(aws_secretsmanager_secret.rds_secret.secret_string)["password"] 
  publicly_accessible               = "false"
  skip_final_snapshot               = "false"
  backup_retention_period           = 7
  subnet_id                         = var.private_data_subnet_az1_id
  vpc_security_group                = [var.rds_security_group_id]

  tags                              = {
    Name                            = "Rds instance placed in the private subnet of az1"
  }
}