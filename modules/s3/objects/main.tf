resource "aws_s3_object" "object" {
  count  = length(var.objects)
  bucket = var.bucket
  key    = var.objects[count.index].key
  source = var.objects[count.index].source
  etag   = lookup(var.objects[count.index], "etag", null)
}
