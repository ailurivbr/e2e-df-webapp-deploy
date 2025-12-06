resource "aws_codepipeline" "main" {
  name     = "doorfeed-terraform"
  role_arn = var.codepipeline_role_arn
  tags = merge(var.tags, {
    Name = "doorfeed-terraform"
  })

  artifact_store {
    location = var.artifacts_bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["source"]

      configuration = {
        Owner      = var.github_details.repository_owner
        Repo       = var.github_details.repository_name
        Branch     = var.github_details.branch_name
        OAuthToken = var.github_personal_access_token

        PollForSourceChanges = false
      }
    }
  }

  stage {
    name = "terraform-checks"
    action {
      name            = "Checks"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      input_artifacts = ["source"]
      version         = "1"

      configuration = {
        ProjectName = var.codebuild_names.checks

        EnvironmentVariables = jsonencode([
          {
            name  = "INFRASTRUCTURE_CODE_PATH"
            value = var.infrastructure_code_path
            type  = "PLAINTEXT"
          }
        ])
      }
    }
  }


  stage {

    name = "terraform-plan"
    action {
      name             = "Plan"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source"]
      version          = "1"
      output_artifacts = ["tf_plan"]

      configuration = {
        ProjectName = var.codebuild_names.plan

        EnvironmentVariables = jsonencode([
          {
            name  = "INFRASTRUCTURE_CODE_PATH"
            value = var.infrastructure_code_path
            type  = "PLAINTEXT"
          }
        ])
      }
    }
  }

  stage {
    name = "apply-terraform-plan"
    action {
      name            = "Apply"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      input_artifacts = ["tf_plan"]
      version         = "1"

      configuration = {
        ProjectName = var.codebuild_names.apply
        EnvironmentVariables = jsonencode([
          {
            name  = "INFRASTRUCTURE_CODE_PATH"
            value = var.infrastructure_code_path
            type  = "PLAINTEXT"
          }
        ])
      }
    }
  }
}

resource "aws_codepipeline_webhook" "main" {
  count = var.add_webhook == true ? 1 : 0

  name            = "df-tf-webhook"
  authentication  = "GITHUB_HMAC"
  target_action   = "Source"
  target_pipeline = aws_codepipeline.main.name

  filter {
    json_path    = "$.ref"
    match_equals = "refs/heads/${var.github_details.branch_name}"
  }
}

resource "github_repository_webhook" "main" {
  count = var.add_webhook == true ? 1 : 0

  repository = var.github_details.repository_name
  events     = ["push"]
}
