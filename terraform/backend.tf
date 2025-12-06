terraform {
  backend "s3" {
    bucket       = "doorfeed-tf-statebucket"
    key          = "infra/doorfeed/infra/dev/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
}
