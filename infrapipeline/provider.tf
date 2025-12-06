provider "aws" {
  region              = "us-east-1"
  allowed_account_ids = ["373527788644"]
}

provider "github" {
  token = "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"
  owner = "ailurivbr"

}