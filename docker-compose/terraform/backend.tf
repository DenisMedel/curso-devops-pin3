terraform {
  backend "s3" {
    bucket         = "s3-tfstate-curso-test"
    region         = "us-east-1"
    key            = "entorno/test/aws-s3-bucket.tfstate"
    dynamodb_table = "terraformstatelock"
  }
}
