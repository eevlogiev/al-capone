resource "aws_key_pair" "deployer" {
  key_name   = "${var.app_name}-key"
  public_key = var.public_key
}