resource "aws_s3_bucket" "source_bucket" {
  bucket = "${var.org_id}-source-bucket"
  acl = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = merge(
    {
      "Name" = format("%s-source-bucket", var.org_id)
    },
    local.web_tags
  )
}

resource "aws_s3_bucket_public_access_block" "s3-source_bucket" {
  bucket   = aws_s3_bucket.source_bucket.id
  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_object" "html" {
  for_each = var.html_files
  bucket       = aws_s3_bucket.source_bucket.bucket
  key          = each.key
  source       = "${var.org_id}-html_files/${each.key}"
  tags = merge(
    local.web_tags
  )
}

resource "aws_s3_bucket_object" "pics" {
  for_each = var.pics
  bucket       = aws_s3_bucket.source_bucket.bucket
  key          = each.key
  source       = "${var.org_id}-html_files/${each.key}"
  tags = merge(
    local.web_tags
  )
}

