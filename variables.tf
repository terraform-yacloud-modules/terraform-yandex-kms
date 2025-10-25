#
# yandex cloud coordinates
#
variable "folder_id" {
  description = "Folder ID"
  type        = string
  default     = null
}

#
# naming
#
variable "name" {
  description = "KMS key name"
  type        = string

  validation {
    condition     = length(var.name) > 0 && length(var.name) <= 63
    error_message = "KMS key name must be between 1 and 63 characters long."
  }

  validation {
    condition     = can(regex("^[a-z]([-a-z0-9]*[a-z0-9])?$", var.name))
    error_message = "KMS key name must start with a lowercase letter, contain only lowercase letters, numbers, and hyphens, and cannot end with a hyphen."
  }
}

variable "description" {
  description = "An optional description of the key."
  type        = string
  default     = null

  validation {
    condition     = var.description == null || (length(var.description) >= 1 && length(var.description) <= 256)
    error_message = "Description must be between 1 and 256 characters long if provided."
  }
}

variable "labels" {
  description = "A set of labels"
  type        = map(string)
  default     = {}

  validation {
    condition     = alltrue([
      for key, value in var.labels :
        length(key) >= 1 && length(key) <= 63 &&
        length(value) >= 1 && length(value) <= 63
    ])
    error_message = "Label keys and values must be between 1 and 63 characters long."
  }

  validation {
    condition     = alltrue([
      for key, value in var.labels :
        can(regex("^[a-z]([-a-z0-9]*[a-z0-9])?$", key))
    ])
    error_message = "Label keys must start with a lowercase letter, contain only lowercase letters, numbers, and hyphens, and cannot end with a hyphen."
  }
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
    error_message = "Default algorithm must be one of: AES_128, AES_192, AES_256."
  }
}

variable "rotation_period" {
  description = "Interval between automatic rotations. To disable automatic rotation, set this parameter equal to null"
  type        = string
  default     = "8760h" # equal to 1 year

  validation {
    condition     = var.rotation_period == null || can(regex("^[1-9][0-9]*[smh]$", var.rotation_period))
    error_message = "Rotation period must be null or a string in the format of number followed by s (seconds), m (minutes), or h (hours)."
  }

  validation {
    condition     = var.rotation_period == null || (
      can(regex("^([1-9][0-9]*)([smh])$", var.rotation_period)) &&
      try(tonumber(regex("^([1-9][0-9]*)[smh]$", var.rotation_period)[0]), 0) > 0
    )
    error_message = "Rotation period must be a positive number followed by s, m, or h."
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

  validation {
    condition = var.timeouts == null || alltrue([
      for key, value in var.timeouts :
        value == null ||
        (can(regex("^[1-9][0-9]*[smh]$", value)) &&
         try(tonumber(regex("^([1-9][0-9]*)[smh]$", value)[0]), 0) > 0)
    ])
    error_message = "Timeout values must be in the format of positive number followed by s (seconds), m (minutes), or h (hours)."
  }
}
