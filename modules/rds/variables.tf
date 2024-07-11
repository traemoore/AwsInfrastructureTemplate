variable "instance_name" {
  description = "Name of the RDS instance."
  type        = string
}

variable "apply_immediately" {
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window."
  type        = bool
  default     = false
}

variable "allocated_storage" {
  description = "The amount of storage to allocate for the DB instance."
  type        = number
}

variable "instance_class" {
  description = "The instance type of the RDS instance."
  type        = string
}

variable "engine" {
  description = "The name of the database engine to be used for this DB instance."
  type        = string
}

variable "engine_version" {
  description = "The version number of the database engine to use."
  type        = string
}

variable "username" {
  description = "Username for the master DB user."
  type        = string
}

variable "password" {
  description = "Password for the master DB user."
  type        = string
  sensitive   = true
}

variable "subnet_group_name" {
  description = "DB subnet group name to use for the DB instance."
  type        = string
}

variable "vpc_security_group_ids" {
  description = "List of VPC security groups to associate."
  type        = list(string)
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "storage_encrypted" {
  description = "Specifies whether the DB instance is encrypted."
  type        = bool
  default     = true
}

variable "publicly_accessible" {
  description = "If true, the DB instance is publicly accessible."
  type        = bool
  default     = false
}

variable "option_group_name" {
  description = "The name of the option group to be used for the DB instance."
  type        = string
  default     = null
}

variable "multi_az" {
  description = "Specifies if the RDS instance is multi-AZ."
  type        = bool
  default     = false
}

variable "ca_cert_identifier" {
  description = "The identifier of the CA certificate for the DB instance."
  type        = string
  default     = "rds-ca-2019" # This is the default for RDS as of now, but it may change in the future.
}

variable "availability_zone" {
  description = "Availability Zone to be used for the DB instance."
  type        = string
}

variable "deletion_protection" {
  description = "If the DB instance should have deletion protection enabled."
  type        = bool
  default     = false
}

variable "backup_window" {
  description = "The daily time range during which automated backups are created if automated backups are enabled."
  type        = string
  default     = "06:00-08:00" # Defaulting to a 2-hour window starting at 7 AM UTC.
}

variable "maintenance_window" {
  description = "The window to perform maintenance in."
  type        = string
  default     = "Sun:04:00-Sun:06:00" # Defaulting to a 2-hour window starting at 5 AM UTC on Mondays.
}

variable "db_name" {
  description = "The name of the Database"
  type        = string
}