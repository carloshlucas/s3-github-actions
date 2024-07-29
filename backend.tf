terraform {
  backend "s3" {
    bucket = "carloslucaswebpage-test-20223"
    key    = "s3"
    region = "eu-west-1"
  }
}