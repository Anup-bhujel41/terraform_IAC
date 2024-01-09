#outputs that we need from the security group module
output "alb_security_group_id" {
  value = aws_security_group.alb_security_group.id
}
output "vpc_security_group_id" {
  value = aws_security_group.vpc_security_group.id
}

output "public_subnet_instance_sg_id" {
  value = aws_security_group.public_subnet_instance_sg.id
}

output "rds_security_group_id" {
  value = aws_security_group.rds_security_group.id
}

output "redis_security_group_id" {
  value = aws_security_group.redis_security_group.id
}