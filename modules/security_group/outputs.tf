#outputs that we need from the security group module
output "alb_security_group_id" {
  value = aws_security_group.alb_security_group.id
}
output "ecs_security_group_id" {
  value = aws_security_group.ecs_security_group.id
}