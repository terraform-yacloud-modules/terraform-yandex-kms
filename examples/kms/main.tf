module "kms_key" {
  source = "../../"

  name              = "my-symmetric-key"
  description       = "My symmetric key description"
  labels            = { "environment" = "production" }
  default_algorithm = "AES_256" # AES_128, AES_192, AES_256
  rotation_period   = "4380h"   # equal to 6 months
}
