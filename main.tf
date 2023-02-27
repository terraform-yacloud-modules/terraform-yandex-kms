resource "yandex_kms_symmetric_key" "this" {
  folder_id = var.folder_id

  name        = var.name
  description = var.description
  labels      = var.labels

  default_algorithm = var.default_algorithm
  rotation_period   = var.rotation_period
}
