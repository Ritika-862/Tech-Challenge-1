data "aws_ssm_parameter" "linux_latest_ami" {
  name = ""
}

resource "aws_instance" "jump_box" {
  ami           = data.aws_ssm_parameter.linux_latest_ami.value
  instance_type = "t2.micro"
  key_name      = "tech_challenge_key"

  subnet_id              = aws_subnet.pub_sub.id
  vpc_security_group_ids = [aws_security_group.general_sg.id, aws_security_group.bastion_sg.id]

  tags = {
    Project = "tech-challenge"
  }
}

resource "aws_instance" "app_instance" {
  ami           = data.aws_ssm_parameter.linux_latest_ami.value
  instance_type = "t2.micro"
  key_name      = "tech_challenge_key"

  subnet_id              = aws_subnet.prv_sub.id
  vpc_security_group_ids = [aws_security_group.general_sg.id, aws_security_group.app_sg.id]

  tags = {
    Project = "tech_challenge"
  }
}