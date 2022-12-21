resource "aws_s3_bucket" "test_alex_tf_bucket" {
    bucket = "${var.bucket_name}"
}

resource "aws_s3_bucket_acl" "test" {
  bucket = aws_s3_bucket.test_alex_tf_bucket.id
  acl = "${var.acl_value}"
}