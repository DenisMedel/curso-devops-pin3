resource "aws_dynamodb_table" "tfstate_lock" {
  name = "terraformstatelock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Nombre = "terraform_state_lock_curso_test"
  }

}
