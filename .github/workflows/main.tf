terraform {

  cloud {

    organization = "ah-ha-admin"

    hostname = "app.terraform.io" # Optional; defaults to app.terraform.io

    workspaces {

      tags = ["networking", "source:cli"]

    }

  }

}
terraform {

  required_providers {

    aws = {

      source  = "hashicorp/aws"

      version = "~> 4.16"

    }

  }

  required_version = ">= 1.2.0"

}

provider "aws" {

  region  = "us-west-2"

}

resource "aws_instance" "app_server" {

  ami           = "ami-08d70e59c07c61a3a"

  instance_type = "t2.micro"

}

terraform init