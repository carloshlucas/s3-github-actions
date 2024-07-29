locals {
  bucket_name = "carlos-ground-jobworkz"
  bucket_name_2 = "carlos-ground-jobworkz-3"
}


resource "aws_s3_bucket" "my_bucket" {
  bucket = local.bucket_name
  
  tags = {
    Name        = local.bucket_name
    Environment = var.region
  }
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = local.bucket_name_2
  
  tags = {
    Name        = local.bucket_name_2
    Environment = var.region
  }
}