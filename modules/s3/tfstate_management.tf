# S3バケットの作成
resource "aws_s3_bucket" "terraform_state" {
  bucket = "tfstate-${var.name_prefix}"
  lifecycle {
    prevent_destroy = true
  }
}

# バージョニングの有効化
resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

# 暗号化の設定
resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_encryption" {
  bucket = aws_s3_bucket.terraform_state.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
