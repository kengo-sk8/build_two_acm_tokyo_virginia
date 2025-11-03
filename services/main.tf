# S3(tfvars_management)
module "s3" {
  source = "../modules/s3"

  name_prefix = local.name_prefix
}

module "acm_tokyo" {
  source = "../modules/acm/tokyo"

  name_prefix = local.name_prefix
  zone_id     = local.zone_id
  zone_name   = local.zone_name
}

module "acm_virginia" {
  source = "../modules/acm/virginia"

  name_prefix = local.name_prefix
  zone_id     = local.zone_id
  zone_name   = local.zone_name
}
