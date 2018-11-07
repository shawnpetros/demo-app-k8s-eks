resource "aws_s3_bucket" "terraform-state-storage-s3" {
  bucket = "arashcuzi-terraform-state"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }

  tags {
    Name = "S3 Remote Terraform State Store"
  }
}

resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name = "terraform-state-lock-dynamo"
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }

  tags {
    Name = "DynamoDB Terraform State Lock Table"
  }
}

terraform {
  backend "s3" {
    encrypt = true
    bucket = "arashcuzi-terraform-state"
    dynamodb_table = "terraform-state-lock-dynamo"
    region = "us-east-1"
    key = "terraform.tfstate"
  }
}
