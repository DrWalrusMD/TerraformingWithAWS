resource "aws_launch_configuration" "main-launchconf" {
  name_prefix     = "main-launchconf"
  image_id        = "ami-0365b50e7a63e3bf1" 
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.mykeypair.key_name
  security_groups = ["${aws_security_group.sgroup-allow-ssh-http.id}"]
  user_data       = file("startup.txt")
  
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "main-as" {
  name                      = "main-as"
  vpc_zone_identifier       = ["${aws_subnet.public-subnet.id}"]
  launch_configuration      = aws_launch_configuration.main-launchconf.name
  min_size                  = 1
  max_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  load_balancers            = [aws_elb.main-elb.name]
  force_delete              = true

  tag {
    key                 = "Name"
    value               = "Cisco EC2 Instance"
    propagate_at_launch = true
  }
}
