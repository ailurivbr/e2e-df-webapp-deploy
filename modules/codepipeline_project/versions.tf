terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.7"
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
  required_version = "> 1.9.5"
}
