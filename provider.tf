terraform {
  required_providers {
    postgresql = {
      source = "cyrilgdn/postgresql"
      version = "1.21.1-beta.1"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}
