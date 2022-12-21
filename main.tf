provider "aws" {
  region = var.region
}

module "s3" {
  source      = "./s3"
  bucket_name = "test-alex-tf-bucket"
}

module "lambda" {
  source = "./lambda"
}