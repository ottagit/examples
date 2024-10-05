terraform {
  required_version = ">= 1.0.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.0.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "webserver_cluster" {
  source = "../../../modules/services/hello-world-app"

  server_text = "Hello, Gophers!"
  environment           = "staging"

  # db_remote_state_bucket = "batoto-bitange"
  # db_remote_state_key    = "stage/data-stores/mysql/terraform.tfstate"

  # Injected dependency
  mysql_config = var.mysql_config

  instance_type = "t2.micro"
  min_size            = 2
  max_size            = 3
  # desired_capacity    = 2
  enable_auto_scaling = true
  ami                 = data.aws_ami.ubuntu.id
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}


