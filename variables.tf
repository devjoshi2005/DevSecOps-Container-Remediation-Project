variable "aws_region" {
  description = "AWS region to deploy resources"
  default = "us-east-1"
  type = string 
}
variable "ecr_repo_name" {
  description = "ECR repository name"
  type = string 
}
variable "ecs_cluster_name" {
  description = "ECS cluster name"  
  type = string 
}

variable "ecs_service_name" {
  description = "ECS service name"
  type = string 

}
variable "container_name" {
  description = "container name"
  type = string 
  
}
variable "container_port" {
  description = "container port"
  type = number

}
