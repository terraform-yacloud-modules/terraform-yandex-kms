module "kms_key" {
  source = "../../"

  folder_id           = var.folder_id
  name                = "lockbox-key"
  description         = "KMS key for Lockbox secret encryption"
  default_algorithm   = "AES_256"
  rotation_period     = "8760h"
  deletion_protection = false
}

resource "yandex_lockbox_secret" "this" {
  folder_id   = var.folder_id
  name        = "my-lockbox-secret"
  description = "Secret encrypted with KMS key from module"
  kms_key_id  = module.kms_key.id
  labels      = var.labels
}
