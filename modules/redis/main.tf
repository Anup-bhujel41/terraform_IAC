#creating redis cluster for the ec2 instance
resource "aws_elasticache_cluster" "redis_cluster" {
  cluster_id = aws_elasticache_cluster.redis_cluster.id
  engine = "redis"
  node_type = "t2.micro" 
  num_cache_nodes = 1
  parameter_group_name = "default.redis3.2"
  engine_version =  "3.2.10"
  port =  6379
  security_group = [var.redis_security_group_id]
  
}