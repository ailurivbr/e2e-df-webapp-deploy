locals {
  name   = "myEC2-new"
  region = "us-east-1"

  user_data = <<-EOT
    #!/bin/bash
    echo "Hello Terraform!"
  EOT

  tags = {
    Name            = local.name
    DeploymentGroup = "Doorfeed-dev-app"
  }
}
