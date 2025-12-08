module "codedeploy" {
  source              = "../modules/codedeploy_project"
  application         = ["doorfeed"]
  env                 = "dev"
  codedeploy_role_arn = aws_iam_role.codedeploy_role.arn
}
