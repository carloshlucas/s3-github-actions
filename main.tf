locals {
  bucket_name = "carlos-ground-jobworkz"
}


resource "aws_s3_bucket" "my_bucket" {
  bucket = local.bucket_name
  
  tags = {
    Name        = local.bucket_name
    Environment = var.region
  }
}

