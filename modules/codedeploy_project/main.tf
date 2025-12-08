resource "aws_codedeploy_app" "main" {
  for_each         = toset(var.application)
  compute_platform = "server"
  name             = "doorfeed-${var.env}-app"
}

resource "aws_codedeploy_deployment_group" "main" {
  for_each              = toset(var.application)
  app_name              = aws_codedeploy_app.main[each.key].app_name
  deployment_group_name = "doorfeed-${var.env}-deployment-group"
  service_role_arn      = var.codedeploy_role_arn

  ec2_tag_set {
    ec2_tag_filter {
      key   = "DeploymentGroup"
      type  = "KEY_AND_VALUE"
      value = "doorfeed-${var.env}"
    }
  }
}