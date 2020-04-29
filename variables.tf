variable "ecs_cluster_name" {
  default = "Test-ECS-cluster"
}
variable "instance_type" {
  default = "t2.medium"
}
variable "max_size" {
  default = 3
}
variable "min_size" {
  default = 1
}
variable "desired_capacity" {
  default = 2
}
variable "key_name" {
  description = "Pem file name for SSH acces into EC2 instance"
}

variable "security_group_id" {
  description = "Security group for Cluster EC2 instances "
}

variable "vpc_public_subnets" {
  description = "Subnets where EC2 instances are deployed"
}

variable "iam_instance_profile" { 
    description = "IAM instance profile ECS app role"
}


