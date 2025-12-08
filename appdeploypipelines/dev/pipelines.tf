resource "aws_codepipeline" "doorfeed_pipeline" {
  name     = "doorfeed-dev-deploy-pipeline"
  role_arn = ""

  artifact_store {
    type     = "S3"
    location = ""
  }

  stage {
    name = "Source"

    action {
      name             = "GitHub_Source"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        Owner      = "ailurivbr"
        Repo       = "e2e-df-webapp-deploy"
        Branch     = "main"
        OAuthToken = "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" # Pls add github Oauth token
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "CodeBuild_Deploy"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = module.codebuild_dev.name
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "DeployToEC2"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeploy"
      version         = "1"
      input_artifacts = ["build_output"]

      configuration = {
        ApplicationName     = "doorfeed-dev-app"
        DeploymentGroupName = "doorfeed-dev-deployment-group"
      }
    }
  }
}

resource "aws_codepipeline_webhook" "main" {
  count = var.add_webhook == false ? 1 : 0

  name            = "df-tf-webhook"
  authentication  = "GITHUB_HMAC"
  target_action   = "Source"
  target_pipeline = aws_codepipeline.doorfeed_pipeline.name

  filter {
    json_path    = "$.ref"
    match_equals = "refs/heads/main"
  }
}

resource "github_repository_webhook" "main" {
  count = var.add_webhook == false ? 1 : 0

  repository = "e2e-df-webapp-deploy"
  events     = ["push"]
}
