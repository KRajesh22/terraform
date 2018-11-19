resource "aws_s3_bucket" "b" {
  bucket = "cit-terraform-test-bucket"
  acl    = "private"

  tags {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
