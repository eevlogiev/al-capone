resource "aws_ecs_cluster" "main" {
    name = "${var.app_name}-cluster"
}

output "web_app_rendered_template" {
  value = local.container_definitions
}

resource "aws_ecs_task_definition" "app" {
    family                   = "web-app-task"
    execution_role_arn       = aws_iam_role.ecs_execution_role.arn
    network_mode             = "awsvpc"
    requires_compatibilities = ["FARGATE"]
    cpu                      = var.fargate_cpu
    memory                   = var.fargate_memory
    container_definitions    = local.container_definitions
}

resource "aws_ecs_service" "main" {
    name            = "${var.app_name}-service"
    cluster         = aws_ecs_cluster.main.id
    task_definition = aws_ecs_task_definition.app.arn
    desired_count   = var.app_count
    launch_type     = "FARGATE"

    network_configuration {
        security_groups  = [aws_security_group.ecs_tasks.id]
        subnets          = aws_subnet.private.*.id
        assign_public_ip = true
    }

    load_balancer {
        target_group_arn = aws_alb_target_group.app.id
        container_name   = var.app_name
        container_port   = var.app_port
    }

    depends_on = [aws_alb_listener.front_end]
}