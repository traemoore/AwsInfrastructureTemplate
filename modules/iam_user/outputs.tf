output "user_arn" {
  description = "The ARN assigned by AWS for this user."
  value       = aws_iam_user.this.arn
}

output "user_unique_id" {
  description = "The unique ID assigned by AWS."
  value       = aws_iam_user.this.unique_id
}

output "password" {
  description = "The unique ID assigned by AWS."
  value       = aws_iam_user_login_profile.this.password
}