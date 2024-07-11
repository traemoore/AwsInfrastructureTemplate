resource "aws_db_instance" "this" {
  identifier                  = var.instance_name
  allocated_storage           = var.allocated_storage
  storage_type                = "gp2"
  engine                      = var.engine
  engine_version              = var.engine_version
  instance_class              = var.instance_class
  db_name                     = var.db_name
  username                    = var.username
  password                    = var.password
  storage_encrypted           = var.storage_encrypted
  publicly_accessible         = var.publicly_accessible
  option_group_name           = var.option_group_name
  multi_az                    = var.multi_az
  ca_cert_identifier          = var.ca_cert_identifier
  availability_zone           = var.availability_zone
  deletion_protection         = var.deletion_protection
  backup_window               = var.backup_window
  maintenance_window          = var.maintenance_window
  timezone                    = var.engine != "postgres" ? "UTC" : null
  allow_major_version_upgrade = true
  apply_immediately           = var.apply_immediately
  auto_minor_version_upgrade  = true
  parameter_group_name        = "default.${var.engine}${split(".", var.engine_version)[0]}"
  skip_final_snapshot         = true
  db_subnet_group_name        = var.subnet_group_name
  vpc_security_group_ids      = var.vpc_security_group_ids

  tags = var.tags
}
