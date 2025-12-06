resource "aws_codebuild_project" "main" {
  name          = var.name
  description   = var.description
  service_role  = var.service_role_arn
  build_timeout = var.build_timeout

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type    = var.compute_type
    image           = var.image
    type            = "LINUX_CONTAINER"
    privileged_mode = false
    environment_variable {
      name  = "ENVIRONMENT_VALUE"
      value = ""
      type  = "PLAINTEXT"
    }
  }

  source {
    type            = "CODEPIPELINE"
    buildspec       = ".aws/buildspec.yml"
    git_clone_depth = 1
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "codebuild/${var.application}"
      stream_name = var.name
    }
  }

  tags = {
    Project     = "doorfeed"
    Environment = "dev"
  }
}

