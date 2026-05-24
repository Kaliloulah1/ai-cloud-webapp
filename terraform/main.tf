terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_ecr_repository" "app" {
  name         = "ai-cloud-webapp"
  force_delete = true
}

resource "aws_ecs_cluster" "app" {
  name = "ai-cloud-webapp-cluster"
}

resource "aws_security_group" "app" {
  name        = "ai-cloud-webapp-sg"
  description = "Allow traffic to app"

  ingress {
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
}

resource "aws_ecs_task_definition" "app" {
  family                   = "ai-cloud-webapp-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = "arn:aws:iam::354130782339:role/ecsTaskExecutionRole"

  container_definitions = jsonencode([{
    name  = "ai-cloud-webapp"
    image = "354130782339.dkr.ecr.us-east-1.amazonaws.com/ai-cloud-webapp:latest"
    portMappings = [{
      containerPort = 8080
      protocol      = "tcp"
    }]
    essential = true
  }])
}

data "aws_subnets" "default" {
  filter {
    name   = "default-for-az"
    values = ["true"]
  }
}

resource "aws_ecs_service" "app" {
  name            = "ai-cloud-webapp-service"
  cluster         = aws_ecs_cluster.app.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = data.aws_subnets.default.ids
    security_groups  = [aws_security_group.app.id]
    assign_public_ip = true
  }
}