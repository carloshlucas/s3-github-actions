locals {
  bucket_name = "carlos-test-test-2-2321"
}


resource "aws_s3_bucket" "my_bucket" {
  bucket = local.bucket_name
  
  tags = {
    Name        = local.bucket_name
    Environment = var.region
  }
}
