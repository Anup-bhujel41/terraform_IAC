#output from the ec2 main config file  
output "Public_subnet_ec2_instance_id" {
  value = aws_instance.Public_subnet_ec2_instance.id
}