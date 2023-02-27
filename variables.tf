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
  description = "Name of lockbox secret"
  type        = string
}

variable "description" {
  description = "Description of the security group"
  type        = string
  default     = ""
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
  description = " Encryption algorithm to be used for this key"
  type        = string
  default     = "AES_128"
}

variable "rotation_period" {
  description = "Interval between automatic rotations. To disable automatic rotation, set this parameter equal to null"
  type        = string
  default     = "8760h"
}
