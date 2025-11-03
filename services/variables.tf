data "aws_route53_zone" "acm_test" {
  name = "example.com"
}
locals {
  zone_id   = data.aws_route53_zone.acm_test.zone_id
  zone_name = data.aws_route53_zone.acm_test.name
}

locals {
  name_prefix  = "acm-test"
}
