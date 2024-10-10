resource "aws_route53_zone" "main" {
  name = var.domain_name
}

# Create a Route 53 DNS Alias record
resource "aws_route53_record" "alb_alias" {
  zone_id = aws_route53_zone.main.zone_id
  name     = var.domain_name
  type     = "A"
  alias {
    name                   = aws_alb.main.dns_name
    zone_id                = aws_alb.main.zone_id
    evaluate_target_health = true
  }                          
  depends_on = [aws_alb.main, aws_route53_zone.main]  
  
}

# Output the ALB DNS name
output "alb_dns_name" {
  value = aws_alb.main.dns_name
}