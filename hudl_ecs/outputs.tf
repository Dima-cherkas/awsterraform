# outputs.tf

output "alb_hostname" {
  value = aws_alb.hudl_project_alb.dns_name
}

