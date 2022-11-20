provider "archive" {}



provider "aws" {
  alias = "useast1"
  region = "us-east-1"
}

provider "aws" {
  alias = "useast2"
  region = "us-east-2"
}

provider "aws" {
  alias = "uswest1"
  region = "us-west-1"
}

provider "aws" {
  alias = "uswest2"
  region = "us-west-2"
}
