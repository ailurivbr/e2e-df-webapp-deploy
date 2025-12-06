resource "aws_codepipeline" "doorfeed_pipeline" {
  name     = "doorfeed-dev-pipeline"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    type     = "S3"
    location = aws_s3_bucket.codepipeline_bucket.bucket
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
        Owner      = "Doorfeed"
        Repo       = "doorfeed-app" # Need to add actual doorfeed githiub repo
        Branch     = "main"
        OAuthToken = "GITHUB_TOKEN" # Pls add github Oauth token
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
        ProjectName = aws_codebuild_project.doorfeed_application_build.name
      }
    }
  }

  stage {
    name = "Test"

    action {
      name             = "RunTests"
      category         = "Test"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["build_output"]
      output_artifacts = ["test_output"]
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.doorfeed_test_project.name
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
        ApplicationName     = aws_codedeploy_app.doorfeed_app.name
        DeploymentGroupName = aws_codedeploy_deployment_group.doorfeed_deployment_group.deployment_group_name
      }
    }
  }
}
