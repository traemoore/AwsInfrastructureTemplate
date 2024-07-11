variable "bucket" {
  description = "The name of the bucket to put the object in."
  type        = string
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
