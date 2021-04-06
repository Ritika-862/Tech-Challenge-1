# Create Launch Template for ASG
resource "aws_launch_template" "AutoScaling-LT" {
  name_prefix   = "AutoScaling-LT"
  image_id      = "ami-1a2b3c"
  instance_type = var.instance_type
  key_name      = var.key_name

  tags = {
    Project = "tech-challenge"
    
  }
}

# Create placement group
resource "aws_placement_group" "AutoPlacement" {
  name          = "AutoPlacement"
  strategy      = "spread"
}

# Create ASG
resource "aws_autoscaling_group" "ASG" {
  name                      = "ASG"
  max_size                  = 3
  min_size                  = 2
  health_check_grace_period = 60
  health_check_type         = "ELB"
  placement_group           = "${aws_placement_group.AutoPlacement.id}"
  availability_zones        = var.az
  vpc_zone_identifier       = [aws_subnet.prv_sub, aws_subnet.prv_sub1]


  launch_template {
    id          = "${aws_launch_template.AutoScaling-LT}"
    version     = "$Default"
  }
}