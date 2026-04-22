terraform {
  backend "s3" {
    bucket       = "codeserver-tf-state-454374565233"
    key          = "infra/dev/terraform-tfstate"
    region       = "eu-west-2"
    encrypt      = true
    use_lockfile = true
  }
}