variable "name" {
  description = "Nmae of the project"
  type        = string
}

variable "description" {
  description = "description of the project"
  type        = string
}

variable "buildspec" {
  description = "Buildspec of the project"
  type        = any
}
variable "application" {
  description = "the application of the project"
  type        = string
}
variable "service_role_arn" {
  description = "The codebuild project service role to be assumed"
  type        = string
}


variable "build_timeout" {
  description = "the timeout for a codebuild project"
  type        = string
  default     = "45"
}
variable "compute_type" {
  description = "the compute type of the codebuild project"
  type        = string
  default     = "BUILD_GENERAL1_SMALL"
}

variable "image" {
  description = "the image to be used in the codebuild project"
  type        = string
  default     = "aws/codebuild/standard:5.0"
}