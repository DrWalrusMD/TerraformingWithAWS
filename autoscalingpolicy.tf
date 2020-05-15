resource "aws_autoscaling_policy" "cpu-policy-up" {
  name                   = "cpu-policy"
  autoscaling_group_name = aws_autoscaling_group.main-as.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "1"
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "cpu-alarm-up" {
  alarm_name          = "cpu-alarm"
  alarm_description   = "Alarm based on if CPU Utilization exceeds 30%"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "30"

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.main-as.name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.cpu-policy-up.arn]
}


resource "aws_autoscaling_policy" "cpu-policy-down" {
  name                   = "cpu-policy-down"
  autoscaling_group_name = aws_autoscaling_group.main-as.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "-1"
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "cpu-alarm-down" {
  alarm_name          = "cpu-alarm-down"
  alarm_description   = "Alarm based on if CPU Utilization is lower than 5%"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "5"

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.main-as.name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.cpu-policy-down.arn]
}
