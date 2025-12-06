resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket        = "doorfeed-dev-codepipeline-artifacts"
  force_destroy = true
}
