output "id" {
  description = "The unique identifier of the KMS symmetric key."
  value       = yandex_kms_symmetric_key.this.id
}

output "created_at" {
  description = "Creation timestamp of the KMS symmetric key."
  value       = yandex_kms_symmetric_key.this.created_at
}

output "rotated_at" {
  description = "Last rotation timestamp of the KMS symmetric key."
  value       = yandex_kms_symmetric_key.this.rotated_at
}

output "status" {
  description = "Status of the KMS symmetric key."
  value       = yandex_kms_symmetric_key.this.status
}
