output "name" {
  description = "code deploy application name"
  value       = values(aws_codedeploy_app.main).*.name
}

output "arn" {
  description = "Codedeployment Name"
  value       = values(aws_codedeploy_deployment_group.main).*.arn
}