# logs.tf

# Set up CloudWatch group and log stream and retain logs for 30 days
resource "aws_cloudwatch_log_group" "hudl_project_group" {
  name              = "/ecs/hudl-project"
  retention_in_days = 30

  tags = {
    Terraform = "true"
    Environment = "hudl_project"
  }
}

resource "aws_cloudwatch_log_stream" "hudl_project_log_stream" {
  name           = "hudl-project-log-stream"
  log_group_name = aws_cloudwatch_log_group.hudl_project_group.name

}

