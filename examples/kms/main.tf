module "kms_key" {
  source = "../../"

  name   = "testkey"
  labels = {}
}
