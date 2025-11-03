terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.19.0"
    }
  }
}

provider "aws" {
  alias  = "virginia"
  region = "us-east-1"
}

# バージニア北部で acm-test.com の ACM 証明書を発行する
resource "aws_acm_certificate" "acm_virginia_test_com" {
  provider          = aws.virginia
  domain_name       = "${var.name_prefix}.${var.zone_name}"
  validation_method = "DNS"
}

# 上記で作成したレコードに基づいて証明書の DNS 検証を実行する
resource "aws_acm_certificate_validation" "acm_virginia_test_com" {
  provider        = aws.virginia
  certificate_arn = aws_acm_certificate.acm_virginia_test_com.arn
  validation_record_fqdns = [
    for dvo in aws_acm_certificate.acm_virginia_test_com.domain_validation_options :
    dvo.resource_record_name
  ]
}

