module "pipelines" {
  source                       = "../modules/codepipeline_project"
  codepipeline_role_arn        = aws_iam_role.codepipeline_role.arn
  github_personal_access_token = "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"

  artifacts_bucket = aws_s3_bucket.codepipeline_bucket.bucket
  tf_version       = "1.9.5"

  github_details = {
    branch_name      = "main"
    repository_owner = "ailurivbr"
    repository_name  = "e2e-df-webapp-deploy"
  }

  codebuild_names = {
    checks = module.codebuild_dev_tf_checks.name
    plan   = module.codebuild_dev_tf_plan.name
    apply  = module.codebuild_dev_tf_apply.name
  }

  infrastructure_code_path = "../terraform"

}
