variable "bucket_name" {
  description = "The name of the bucket"
  type        = string
}

variable "bucket_acl" {
  description = "The access control list (ACL) of the bucket"
  type        = string
  default     = "NULL"
}

variable "versioning" {
  description = "Enable versioning for the bucket"
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to assign to the bucket"
  type        = map(string)
  default     = {}
}

variable "objects" {
  description = "List of S3 objects to create. Each object accepts source, key, and etag."
  type = list(object({
    source = string
    key    = string
    etag   = optional(string)
  }))
  default = []
}