output "id" {
  description = "The unique identifier of the KMS symmetric key."
  value       = module.kms_key.id
}

output "created_at" {
  description = "Creation timestamp of the KMS symmetric key."
  value       = module.kms_key.created_at
}

output "rotated_at" {
  description = "Last rotation timestamp of the KMS symmetric key."
  value       = module.kms_key.rotated_at
}

output "status" {
  description = "Status of the KMS symmetric key."
  value       = module.kms_key.status
}
