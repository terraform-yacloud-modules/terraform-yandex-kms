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
}

variable "description" {
  description = "An optional description of the key."
  type        = string
  default     = null
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
