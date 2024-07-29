output "id" {
  description = "The unique identifier of the KMS symmetric key."
  value       = yandex_kms_symmetric_key.this.id
}
