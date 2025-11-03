# 東京リージョンで acm-test.com の ACM 証明書を発行する
resource "aws_acm_certificate" "acm_tokyo_test_com" {
  domain_name       = "${var.name_prefix}.${var.zone_name}"
  validation_method = "DNS"
}

# 上記で作成したレコードに基づいて証明書の DNS 検証を実行する
resource "aws_acm_certificate_validation" "acm_tokyo_test_com" {
  certificate_arn = aws_acm_certificate.acm_tokyo_test_com.arn
  validation_record_fqdns = [
    for r in aws_route53_record.acm_tokyo_test_com : r.fqdn
  ]
}

# DNS 検証用の Route53 レコードを（対象ドメイン分だけ）作成する
resource "aws_route53_record" "acm_tokyo_test_com" {
  for_each = {
    for dvo in aws_acm_certificate.acm_tokyo_test_com.domain_validation_options :
    dvo.domain_name => {
      name         = dvo.resource_record_name
      type         = dvo.resource_record_type
      record_value = dvo.resource_record_value
    }
  }

  zone_id = var.zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = 60
  records = [each.value.record_value]
}
