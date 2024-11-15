
resource "aws_ecs_cluster" "main" {
  name = var.cluster_name
  tags = {
    Name = var.cluster_name
  }
}

resource "aws_ecs_service" "backend" {
  name            = "backend-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.backend.arn
  desired_count   = 2
}

resource "aws_ecs_task_definition" "backend" {
  family                   = "backend-task"
  container_definitions    = jsonencode([{
    name      = "backend"
    image     = "your-docker-image-url"
    memory    = 512
    cpu       = 256
    essential = true
    portMappings = [{
      containerPort = 3000
      hostPort      = 0
    }]
  }])
}
                