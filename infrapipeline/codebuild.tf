module "codebuild_dev_tf_checks" {
  source = "../modules/codebuild_project"

  name             = "tf-checks"
  description      = "doorfeed application biuld pipeline"
  application      = "dev-app"
  buildspec        = ""
  service_role_arn = aws_iam_role.codebuild_role.arn

}

module "codebuild_dev_tf_plan" {
  source = "../modules/codebuild_project"

  name             = "tf-plan"
  description      = "doorfeed application build pipeline"
  application      = "dev-app"
  buildspec        = ""
  service_role_arn = aws_iam_role.codebuild_role.arn

}

module "codebuild_dev_tf_apply" {
  source = "../modules/codebuild_project"

  name             = "tf-apply"
  description      = "doorfeed application apply pipeline"
  application      = "dev-app"
  buildspec        = ""
  service_role_arn = aws_iam_role.codebuild_role.arn

}
