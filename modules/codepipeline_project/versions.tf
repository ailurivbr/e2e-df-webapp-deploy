terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "> 4.28.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "> 3.4.3"
    }
    github = {
      source  = "integrations/github"
      version = ">= 5.0.0"
    }
  }
  required_version = ">= 1.5.4"
}
