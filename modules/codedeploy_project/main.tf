resource "aws_codedeploy_app" "main" {
  for_each         = toset(var.application)
  compute_platform = "server"
  name             = "hvcp-${var.env}-${each.key}-app"
}

resource "aws_codedeploy_deployment_group" "main" {
  for_each               = toset(var.application)
  app_name               = aws_codedeploy_app.main[each.key].app_name
  deployment_group_name  = "hvcp-${var.env}-${each.key}-deployment-group"
  service_role_arn       = var.codedeploy_role_arn
  deployment_config_name = contains(["pc-online", "cc-online", "cccm-online", "mu"], each.key) ? "CodeDeployDefault.ALLAtOnce" : "CodeDeployDefault.OneAtATime"

  ec2_tag_set {
    ec2_tag_filter {
      key   = "DeploymentGroup"
      type  = "KEY_AND_VALUE"
      value = "hvcp-${var.env}-${each.key}"
    }
  }
}