output "name" {
  description = "Name of the codebuild project creted"
  value       = aws_codebuild_project.main.name
}

output "arn" {
  description = "Arn of the codebuild project created"
  value       = aws_codebuild_project.main.arn
}