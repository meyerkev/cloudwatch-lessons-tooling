provider "aws" {
    region = "us-east-2"
}

terraform {
    backend "s3" {
        bucket = "meyerkev-terraform-state"
        key = "cloudwatch-class.tfstate"
        region = "us-east-2"
    }
}
