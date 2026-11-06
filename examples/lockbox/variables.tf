variable "folder_id" {
  description = "Folder ID where the KMS key and Lockbox secret will be created. Defaults to the provider folder."
  type        = string
  default     = null
}

variable "labels" {
  description = "Labels for Lockbox secret"
  type        = map(string)
  default     = {}
}
