terraform {
  backend "s3" {}
}

resource "aws_kms_key" "test_alex_td_bucket_key" {
  description             = "Tester terraform, kan slettes"
  enable_key_rotation = true
}

resource "aws_s3_bucket" "test_alex_tf_bucket" {
    bucket = "${var.bucket_name}"
}

resource "aws_s3_bucket_acl" "test_alex_acl" {
  bucket = aws_s3_bucket.test_alex_tf_bucket.id
  acl = "${var.acl_value}"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.test_alex_tf_bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.test_alex_td_bucket_key.id
      sse_algorithm     = "aws:kms"
    }
  }
}