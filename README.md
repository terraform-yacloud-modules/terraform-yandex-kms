# Yandex Cloud KMS Terraform module

Terraform module which creates Yandex Cloud KMS resources.

## Input Validation

This module includes input validation to catch configuration errors early and provide clear error messages:

- **`default_algorithm`**: Must be one of `AES_128`, `AES_192`, or `AES_256`
- **`rotation_period`**: Must be a valid duration string (e.g., `8760h`, `24h`, `30m`) or `null` to disable rotation
- **`name`**: Must be 1-63 characters long (Yandex Cloud accepts various characters including special symbols)
- **`description`**: Must be 256 characters or less or `null`

**Note**: The `folder_id` field does not have client-side validation as Yandex Cloud accepts various formats. Validation occurs during `terraform apply`.

These validations help catch configuration errors early during `terraform plan` rather than during `terraform apply`.

## Examples

Examples codified under
the [`examples`](https://github.com/terraform-yacloud-modules/terraform-yandex-kms/tree/main/examples) are intended
to give users references for how to use the module(s) as well as testing/validating changes to the source code of the
module. If contributing to the project, please be sure to make any appropriate updates to the relevant examples to allow
maintainers to test your changes and to keep the examples up to date for users. Thank you!

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_yandex"></a> [yandex](#requirement\_yandex) | >= 0.72.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | >= 0.72.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [yandex_kms_symmetric_key.this](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/kms_symmetric_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_default_algorithm"></a> [default\_algorithm](#input\_default\_algorithm) | Encryption algorithm to be used for this key | `string` | `"AES_128"` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | Whether the key is protected from deletion. If true, the key cannot be deleted | `bool` | `false` | no |
| <a name="input_description"></a> [description](#input\_description) | An optional description of the key. | `string` | `null` | no |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | Folder ID | `string` | `null` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | A set of labels | `map(string)` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | KMS key name | `string` | n/a | yes |
| <a name="input_rotation_period"></a> [rotation\_period](#input\_rotation\_period) | Interval between automatic rotations. To disable automatic rotation, set this parameter equal to null | `string` | `"8760h"` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | Timeout settings for cluster operations | <pre>object({<br/>    create = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_created_at"></a> [created\_at](#output\_created\_at) | Creation timestamp of the KMS symmetric key. |
| <a name="output_id"></a> [id](#output\_id) | The unique identifier of the KMS symmetric key. |
| <a name="output_rotated_at"></a> [rotated\_at](#output\_rotated\_at) | Last rotation timestamp of the KMS symmetric key. |
| <a name="output_status"></a> [status](#output\_status) | Status of the KMS symmetric key. |
<!-- END_TF_DOCS -->

## License

Apache-2.0 Licensed.
See [LICENSE](https://github.com/terraform-yacloud-modules/terraform-yandex-kms/blob/main/LICENSE).
