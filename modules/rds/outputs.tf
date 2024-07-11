output "db_instance_endpoint" {
  description = "The connection endpoint for the DB instance."
  value       = aws_db_instance.this.endpoint
}

output "db_instance_arn" {
  description = "The ARN of the DB instance."
  value       = aws_db_instance.this.arn
}

output "db_instance_name" {
  description = "The name of the DB instance."
  value       = aws_db_instance.this.db_name
}

output "db_identifier" {
  description = "The name of the DB instance."
  value       = aws_db_instance.this.identifier
}

output "db_instance_port" {
  description = "The port on which the DB instance accepts connections."
  value       = aws_db_instance.this.port
}

output "db_instance_publicly_accessible" {
  description = "Indicates if the DB instance is publicly accessible."
  value       = aws_db_instance.this.publicly_accessible
}

output "db_option_group_name" {
  description = "The name of the option group for the DB instance."
  value       = aws_db_instance.this.option_group_name
}
