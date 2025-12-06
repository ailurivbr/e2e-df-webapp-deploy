variable "application" {
  description = list(any)
}
variable "env" {
  description = "The mule environment to be deployed to"
  type        = string
}
variable "codedeploy_role_arn" {
  description = "the arn of the codepipeline role"
  type        = string
}