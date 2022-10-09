terraform {
  required_version = ">= 1.1.0"
  required_providers {
    aws = {
      version = ">= 2.28.1"
    }
    local = {
      version = "~> 2"
    }
  }
}
