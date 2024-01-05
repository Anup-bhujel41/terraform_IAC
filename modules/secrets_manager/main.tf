#main config file for the secrets management using the KMS key and random password

#creating the random password for the mysql database
resource "random_password" "rds_password" {
  length                        =  10
  special                       = true

}


#creating KMS Key for the password encryption
resource "aws_kms_key" "rds_kms_key" {
  description                   = "rds_kms_key"
  enable_key_rotation           = true

}

#creating the secrets manager for the secrets management
resource "aws_secretsmanager_secret" "rds_secret" {
  name                          = "mysql db credential"
  kms_key_id                    = aws_kms_key.rds_kms_key.key_id


#loading the random password from above
  secret_string                 = jsoncode({
    password                    = random_password.rds_password.result
  })

}


#creating the secret version
resource "aws_secretsmanager_secret_version" "rds_secret_version" {
  secret_id                     = aws_secretsmanager_secret.rds_secret.id
  secret_version                = aws_secretsmanager_secret.rds_secret.secret_string
}




