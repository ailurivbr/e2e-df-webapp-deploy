resource "aws_codedeploy_app" "doorfeed_app" {
  name             = "doorfeed-webapp"
  compute_platform = "Server"
}

resource "aws_codedeploy_deployment_group" "doorfeed_deployment_group" {
  app_name              = aws_codedeploy_app.doorfeed_app.name
  deployment_group_name = "doorfeed-dev-dg"
  service_role_arn      = aws_iam_role.codedeploy_role.arn

  deployment_style {
    deployment_type   = "IN_PLACE"
    deployment_option = "WITH_TRAFFIC_CONTROL"
  }

  ec2_tag_set {
    ec2_tag_filter {
      key   = "App"
      type  = "KEY_AND_VALUE"
      value = "doorfeed-dev"
    }
  }
}
