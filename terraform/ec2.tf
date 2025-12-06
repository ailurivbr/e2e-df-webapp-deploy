module "ec2_complete" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "v6.1.5"
  name    = local.name

  ami           = "ami-0fa3fe0fa7920f68e"
  instance_type = "t3.micro"
  #   availability_zone           = "us-east-1"
  subnet_id                   = "subnet-0121af17b01e9f18b"
  vpc_security_group_ids      = [module.security_group.security_group_id]
  create_iam_instance_profile = true
  iam_role_description        = "IAM role for EC2 instance"
  iam_role_policies = {
    AdministratorAccess = "arn:aws:iam::aws:policy/AdministratorAccess"
  }


  user_data_base64            = base64encode(local.user_data)
  user_data_replace_on_change = false

  cpu_options = {
    core_count       = 1
    threads_per_core = 1
  }
  enable_volume_tags = false
  root_block_device = {
    encrypted  = true
    type       = "gp3"
    throughput = 150
    size       = 50
    tags = {
      Name = "my-root-block"
    }
  }

  ebs_volumes = {
    "/dev/sdf" = {
      size       = 5
      throughput = 150
      encrypted  = true
      kms_key_id = aws_kms_key.this.arn
      tags = {
        MountPoint = "/mnt/data"
      }
    }
  }

  tags = local.tags
}

resource "aws_kms_key" "this" {
}

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = local.name
  description = "Security group for example usage with EC2 instance"
  vpc_id      = "vpc-0bbf0af915f0bf290"

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "all-icmp"]

}
