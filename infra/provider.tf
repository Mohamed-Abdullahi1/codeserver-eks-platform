terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 6.42.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "= 3.1.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "= 3.1.1"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes = {
    config_path = "~/.kube/config"
  }
}