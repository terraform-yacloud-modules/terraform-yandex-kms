output "id" {
  description = "The unique identifier of the KMS symmetric key."
  value       = module.kms_key.id
}
