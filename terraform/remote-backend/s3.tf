module "s3_state_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "v5.9.0"

  bucket = "doorfeed-tf-statebucket"

  attach_policy                         = true
  attach_deny_insecure_transport_policy = true

  # Enable versioning
  versioning = {
    enabled = true
  }

  tags = {
    Environment = "Dev"
    Project     = "doorfeed"
    ManagedBy   = "Terraform"
  }
}
