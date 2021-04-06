# Create Loadbalancer target group
resource "aws_lb_target_group" "targetgroup" {
  name          = "targetgroup"
  port          = "80"
  protocol      = "HTTP"
  vpc_id        = "${aws_vpc.main.id}"
  target_type   = "instance"

  tags = {
    name        = "tech-challenge"
      }

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 10
    timeout             = 5
    interval            = 10
    path                = "/"
    port                = "80"
  }
}

# Create ELB - Application loadbalancer
resource "aws_lb" "elb" {
  name               = "elb"
  subnets            = ["${aws_subnet.prv_sub.id}","${aws_subnet.prv_sub1.id}"]
  internal           = false
  load_balancer_type = "application"
 
  tags = {
    Name        = "tech-challenge"
    
  }
}

# Create Application LB listener
resource "aws_lb_listener" "listener" {
  load_balancer_arn = "${aws_lb.elb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn    = "${aws_lb_target_group.targetgroup.arn}"
    type                = "forward"
  }
}
