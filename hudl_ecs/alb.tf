# alb.tf

resource "aws_alb" "hudl_project_alb" {
  name            = "hudl-project-alb"
  subnets         = aws_subnet.public.*.id
  security_groups = [aws_security_group.lb.id]

  tags = {
    Terraform = "true"
    Environment = "hudl_project"
  }
}

resource "aws_alb_target_group" "app" {
  name        = "hudl-project-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.hudl_project_vpc.id
  target_type = "ip"

  tags = {
    Terraform = "true"
    Environment = "hudl_project"
  }

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = var.health_check_path
    unhealthy_threshold = "2"
  }
}

# Redirect all traffic from the ALB to the target group
resource "aws_alb_listener" "front_end" {
  load_balancer_arn = aws_alb.hudl_project_alb.id
  port              = var.app_port
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.app.id
    type             = "forward"
  }
}
