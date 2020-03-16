output "ecs_cluster_id" {
  description = "Id of created ECS cluster"
  value       = aws_ecs_cluster.test-ecs-cluster.id
}