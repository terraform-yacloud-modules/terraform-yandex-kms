#
# yandex cloud coordinates
#
variable "folder_id" {
  description = "Folder ID"
  type        = string
  default     = null

  validation {
    condition     = var.folder_id == null || can(regex("^[a-z0-9]{20}$", var.folder_id))
    error_message = "The folder_id must be a valid Yandex Cloud folder ID (20 character alphanumeric string) or null."
  }
}

#
# naming
#
variable "name" {
  description = "KMS key name"
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9-]{1,63}$", var.name))
    error_message = "The name must be 1-63 characters long and contain only lowercase letters, numbers, and hyphens."
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
}

variable "rotation_period" {
  description = "Interval between automatic rotations. To disable automatic rotation, set this parameter equal to null"
  type        = string
  default     = "8760h" # equal to 1 year
}
