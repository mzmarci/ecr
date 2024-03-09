terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.67.0"
    }
  }

/*     backend "s3" {
    bucket = "workspacebucket-2023"
    key    = "Dev/terraform.tfstate"
    region = "eu-west-1"
  } */

  required_version = ">=1.2.0"
}


provider "aws" {
  region = "eu-west-1"
}

resource "aws_s3_bucket" "simple-mercy-bucket" {
  bucket = var.bucket

  tags = {
    Name        = "my-bucket"
    Environment = "Dev"

  }
}

/* resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.simple-mercy-bucket.id
  acl    = "private"
} */

resource "aws_s3_bucket_lifecycle_configuration" "s3-bucket" {
  rule {
    id     = "log" // one can also use archive. Unique identifier for the rule. The value cannot be longer than 255 characters
    status = "Enabled"


    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 60
      storage_class = "GLACIER"
    }

    expiration {
      days = 365
    }
  }

  bucket = aws_s3_bucket.simple-mercy-bucket.id
}

resource "aws_s3_bucket" "versioning-bucket" {
  bucket = var.versioning-bucket
}

/* resource "aws_s3_bucket_acl" "versioning_bucket_acl" {
  bucket = aws_s3_bucket.versioning-bucket.id
  acl    = "private"
} */

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.versioning-bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "versioning-bucket-config" {
  # Must have bucket versioning enabled first
  depends_on = [aws_s3_bucket_versioning.versioning]

  bucket = aws_s3_bucket.versioning-bucket.id

  rule {
    id     = "log"
    status = "Enabled"

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 60
      storage_class = "GLACIER"
    }

    expiration {
      days = 365
    }
  }
}
