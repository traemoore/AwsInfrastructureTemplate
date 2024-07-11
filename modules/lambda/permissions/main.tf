resource "aws_lambda_permission" "cognito_permission" {
  count = length(var.permissions)
  statement_id  = var.permissions[count.index].statement_id
  action        = var.permissions[count.index].action
  function_name = var.permissions[count.index].function_name
  principal     = var.permissions[count.index].principal
}

variable "permissions" {
  type = list(object({
    statement_id   = string
    action     = string
    function_name    = string
    principal    = string
  }))
}