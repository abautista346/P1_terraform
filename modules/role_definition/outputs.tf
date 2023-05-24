//OUTPUT

output "arn_iam_profile" {
  description   =   "arn value of my profile with access"   
  value         =   aws_iam_instance_profile.iam_profile.arn
}