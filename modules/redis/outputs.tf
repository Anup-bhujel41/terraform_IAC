#outputs from redis resource
output "redis_cluster_id" {
  value = aws_elasticcache_cluster.redis_cluster.id

}

