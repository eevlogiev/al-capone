locals {
#  name      = "al-capone"
#   source_ip = "0.0.0.0/0"
#   region    = "us-east-1"

#   private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
#   public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

#   azs           = ["us-east-1a", "us-east-1b"]
#   vpc_cidr      = "10.0.0.0/16"
#   instance_type = "t2.small"
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
