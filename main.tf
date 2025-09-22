#VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true 
  enable_dns_hostnames = true 
  tags={Name="ecs-vpc"}
}
#Internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id 
  tags={
    Name="ecs-igw"
  }
}
#public subnets (2 for HA)
resource "aws_subnet" "public_a" {
  vpc_id = aws_vpc.main.id 
  cidr_block = "10.0.1.0/24"
  availability_zone = "${var.aws_region}a"
  map_public_ip_on_launch = true 
  tags = {Name="ecs-public-a"}
}
resource "aws_subnet" "public_b" {
  vpc_id = aws_vpc.main.id 
  cidr_block = "10.0.2.0/24"
  availability_zone = "${var.aws_region}b"
  map_public_ip_on_launch = true 
  tags = {Name="ecs-public-b"}
}
#route table for public subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id 
  route{
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id 
  }
  tags = {Name="ecs-public-rt"}
}
#associate route table
resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}


resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public.id
}

# Security Group for ECS Tasks
resource "aws_security_group" "ecs_sg" {
  name        = "ecs-sg"
  description = "Allow HTTP access"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTP"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "ecs-sg" }
}





resource "aws_ecr_repository" "app_repo" {
  name = var.ecr_repo_name
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
  region = var.aws_region
}
resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "ecs-task-execution-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_role_assume_role_policy.json
}



data "aws_iam_policy_document" "ecs_task_execution_role_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}


resource "aws_ecs_cluster" "app_cluster" {
  name=var.ecs_cluster_name
}
resource "aws_ecs_task_definition" "app_task" {
  family = var.container_name
  requires_compatibilities = ["FARGATE"]
  network_mode = "awsvpc"
  cpu="256"
  memory = "512"
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn 
  
  container_definitions = jsonencode([
    {
      name=var.container_name
      image="${aws_ecr_repository.app_repo.repository_url}:latest"
      essential=true
      portMappings=[{
        containerPort=var.container_port
        hostPort = var.container_port
      }]
    }
  ])
}

resource "aws_ecs_service" "app_service" {
  name=var.ecs_service_name
  cluster = var.ecs_cluster_name
  task_definition = aws_ecs_task_definition.app_task.arn 
  desired_count = 1 
  launch_type = "FARGATE"
  network_configuration {
    subnets = [aws_subnet.public_a.id,aws_subnet.public_b.id]
    assign_public_ip = true 
    security_groups = [aws_security_group.ecs_sg.id]
  }
}