module "wrapper" {
  source = "../"

  for_each = var.items

  name              = try(each.value.name, var.defaults.name, null)
  folder_id         = try(each.value.folder_id, var.defaults.folder_id, null)
  description       = try(each.value.description, var.defaults.description, null)
  labels            = try(each.value.labels, var.defaults.labels, {})
  default_algorithm = try(each.value.default_algorithm, var.defaults.default_algorithm, "AES_128")
  rotation_period   = try(each.value.rotation_period, var.defaults.rotation_period, "8760h")
}
