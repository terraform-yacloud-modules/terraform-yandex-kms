#
# yandex cloud coordinates
#
variable "folder_id" {
  description = "Folder ID"
  type        = string
  default     = null

  # Note: folder_id validation removed as Yandex Cloud provider accepts various formats
  # The provider will validate the format at apply time
}

#
# naming
#
variable "name" {
  description = "KMS key name"
  type        = string

  validation {
    condition     = length(var.name) >= 1 && length(var.name) <= 63
    error_message = "The name must be 1-63 characters long."
  }
}

variable "description" {
  description = "An optional description of the key."
  type        = string
  default     = null

  validation {
    condition     = var.description == null || length(var.description) <= 256
    error_message = "The description must be 256 characters or less."
  }
}

variable "labels" {
  description = "A set of labels"
  type        = map(string)
  default     = {}
}

#
# kms configuration
#
variable "default_algorithm" {
  description = "Encryption algorithm to be used for this key"
  type        = string
  default     = "AES_128" # AES_128, AES_192, AES_256

  validation {
    condition     = contains(["AES_128", "AES_192", "AES_256"], var.default_algorithm)
    error_message = "The default_algorithm must be one of: AES_128, AES_192, AES_256."
  }
}

variable "rotation_period" {
  description = "Interval between automatic rotations. To disable automatic rotation, set this parameter equal to null"
  type        = string
  default     = "8760h" # equal to 1 year

  validation {
    condition = var.rotation_period == null || can(regex("^[0-9]+(h|m|s)$", var.rotation_period))
    error_message = "The rotation_period must be a valid duration string (e.g., '8760h', '24h', '30m') or null to disable rotation."
  }
}

variable "deletion_protection" {
  description = "Whether the key is protected from deletion. If true, the key cannot be deleted"
  type        = bool
  default     = false
}

variable "timeouts" {
  description = "Timeout settings for cluster operations"
  type = object({
    create = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default = null
}
