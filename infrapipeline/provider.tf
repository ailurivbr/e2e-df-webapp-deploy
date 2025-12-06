provider "aws" {
  region              = "us-east-1"
  allowed_account_ids = ["373527788644"]
}

provider "github" {
  token = ""
  owner = "ailurivbr"

}