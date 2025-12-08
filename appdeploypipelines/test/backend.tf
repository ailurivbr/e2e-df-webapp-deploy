terraform {
  backend "s3" {
    bucket         = "doorfeed-tf-statebucket"
    key            = "infra/doorfeed/deploy-pipelines/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "doorfeed-tf-locktable"
  }
}
