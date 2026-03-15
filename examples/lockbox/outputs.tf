output "kms_key_id" {
  description = "ID of the KMS symmetric key used for Lockbox encryption."
  value       = module.kms_key.id
}

output "lockbox_secret_id" {
  description = "ID of the Lockbox secret."
  value       = yandex_lockbox_secret.this.id
}
