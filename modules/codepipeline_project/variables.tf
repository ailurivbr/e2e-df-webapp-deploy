variable "infrastructure_code_path" {
  description = "The infrastructure code path to be built"
  type        = string
}
variable "codepipeline_role_arn" {
  description = "The role that needs to b assumed to deploy"
  type        = string
}

variable "github_details" {
  description = "Github detailes for the build stage"
  type = object({
    repository_name  = string
    repository_owner = string
    branch_name      = string
  })
}

variable "artifacts_bucket" {
    description = "artifacts buckets"
    type = string
  
}
variable "codebuild_names" {
  description = "the codebuild names for the different steps"
  type = object({
    checks = string
    plan   = string
    apply  = string
  })
}

variable "add_webhook" {
  description = "Should a webhook be added"
  type        = bool
  default     = false
}

variable "github_personal_access_token" {
  description = "PAT token"
  type        = string
}

variable "tags" {
  description = "The tag to be applied to this module"
  type        = map(string)
  default = {
  }
}