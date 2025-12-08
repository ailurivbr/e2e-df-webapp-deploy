module "codebuild_dev" {
  source = "../modules/codebuild_project"

  name             = "doorfeed-dev-build"
  description      = "doorfeed application biuld pipeline"
  application      = "dev-app"
  buildspec        = "./buildspec-deploy.yml"
  service_role_arn = ""

}
