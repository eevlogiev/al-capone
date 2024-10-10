locals {
  account_id    = data.aws_caller_identity.current.account_id
  domain        = "ev4o.com"
  container_definitions = templatefile("./templates/ecs/web_app.json.tpl", {
    app_name       = var.app_name
    app_image      = "${local.account_id}.dkr.ecr.us-east-1.amazonaws.com/al-capone"
    app_port       = var.app_port
    fargate_cpu    = var.fargate_cpu
    fargate_memory = var.fargate_memory
    aws_region     = var.aws_region
  })
}
