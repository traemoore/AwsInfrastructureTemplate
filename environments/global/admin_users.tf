module "template_super_admin" {
  source              = "../../modules/iam_user"
  user_name           = "trae"
  attached_policy_arns = [
    "arn:aws:iam::aws:policy/AdministratorAccess"
  ]
}

output "template_super_admin_temp_password" {
  value     = module.trae_super_admin.password
  sensitive = true
}
