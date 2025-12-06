resource "aws_codebuild_project" "doorfeed_application_build" {
  name          = "doorfeed-dev-application"
  description   = "doorfeed application deploy pipeline"
  service_role  = aws_iam_role.codebuild_role.arn
  build_timeout = "45"

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:7.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = false
    environment_variable {
      name  = "ENVIRONMENT_VALUE"
      value = "dev"
      type  = "Plaintext"
    }
  }

  source {
    type            = "CODEPIPELINE"
    buildspec       = ".aws/buildspec.yml"
    git_clone_depth = 1
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "codebuild/doorfeed-dev-application"
      stream_name = "build-logs"
    }
  }

  tags = {
    Project     = "doorfeed"
    Environment = "dev"
  }
}

resource "aws_codebuild_project" "doorfeed_test_project" {
  name         = "doorfeed-dev-test"
  description  = "Runs tests for doorfeed application"
  service_role = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:7.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = false
  }

  source {
    type            = "GITHUB"
    location        = "https://github.com/example/doorfeed-app.git"
    buildspec       = ".aws/buildspectest.yml"
    git_clone_depth = 1
  }

  build_timeout = 30

  logs_config {
    cloudwatch_logs {
      group_name  = "/aws/codebuild/doorfeed-dev-tests"
      stream_name = "test-logs"
    }
  }

  tags = {
    Project     = "doorfeed"
    Environment = "dev"
  }
}

