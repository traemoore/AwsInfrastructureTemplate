resource "aws_iam_user" "this" {
  name = var.user_name
  path = var.path
}

resource "aws_iam_user_policy_attachment" "this" {
  count      = length(var.attached_policy_arns)
  user       = aws_iam_user.this.name
  policy_arn = var.attached_policy_arns[count.index]
}

resource "aws_iam_user_login_profile" "this" {
  user    = aws_iam_user.this.name
  # password = var.default_password
  password_reset_required = true
}