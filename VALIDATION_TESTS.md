# Validation Tests

This document outlines the validation tests for the KMS module variables.

## Test Cases

### 1. Valid Inputs (Should Pass)

#### Example 1: Basic valid configuration
```hcl
name              = "my-kms-key"
description       = "A valid description"
default_algorithm = "AES_128"
rotation_period   = "8760h"
folder_id         = "b1g12345678901234567"  # 20 char alphanumeric
```

#### Example 2: All valid algorithms
```hcl
# AES_128
default_algorithm = "AES_128"

# AES_192  
default_algorithm = "AES_192"

# AES_256
default_algorithm = "AES_256"
```

#### Example 3: Valid time periods
```hcl
rotation_period = "8760h"    # 1 year in hours
rotation_period = "4380h"    # 6 months in hours
rotation_period = "1440m"    # 1 day in minutes
rotation_period = "86400s"   # 1 day in seconds
rotation_period = null       # Disable rotation
```

#### Example 4: Valid names
```hcl
name = "my-key"
name = "key-123"
name = "a"                   # Minimum length
name = "a123456789012345678901234567890123456789012345678901234567890123" # Maximum length (63)
```

### 2. Invalid Inputs (Should Fail)

#### Invalid Algorithm
```hcl
# Test command: terraform plan -var="default_algorithm=AES_512"
default_algorithm = "AES_512"     # Should fail with: "The default_algorithm must be one of: AES_128, AES_192, AES_256."
default_algorithm = "INVALID"     # Should fail with: "The default_algorithm must be one of: AES_128, AES_192, AES_256."
default_algorithm = "aes_128"     # Should fail (case sensitive)
```

#### Invalid Rotation Period
```hcl
# Test command: terraform plan -var="rotation_period=invalid"
rotation_period = "invalid"       # Should fail with: "The rotation_period must be a valid duration string..."
rotation_period = "8760"          # Should fail (missing unit)
rotation_period = "8760d"         # Should fail (days not supported)
rotation_period = "1.5h"          # Should fail (decimal not supported)
```

#### Invalid Name
```hcl
# Test command: terraform plan -var="name=Invalid-Name"
name = "Invalid-Name"             # Should fail (uppercase letters)
name = "my_key"                   # Should fail (underscore not allowed)
name = "my key"                   # Should fail (space not allowed)
name = ""                         # Should fail (empty string)
name = "a1234567890123456789012345678901234567890123456789012345678901234" # Should fail (64 chars, too long)
```

#### Invalid Folder ID
```hcl
# Test command: terraform plan -var="folder_id=invalid"
folder_id = "invalid"             # Should fail (wrong format)
folder_id = "B1G12345678901234567" # Should fail (uppercase)
folder_id = "b1g123456789012345"   # Should fail (too short - 19 chars)
folder_id = "b1g123456789012345678" # Should fail (too long - 21 chars)
folder_id = "b1g1234567890123456!" # Should fail (special character)
```

#### Invalid Description
```hcl
description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
# Should fail (> 256 characters)
```

## Current Example Validation

The existing example in `examples/kms/main.tf` should pass all validations:
- ✅ `name = "my-symmetric-key"` (valid format)
- ✅ `description = "My symmetric key description"` (< 256 chars)
- ✅ `default_algorithm = "AES_256"` (valid algorithm)
- ✅ `rotation_period = "4380h"` (valid duration)
- ✅ `folder_id` not specified (uses null default)

## Validation Rules Summary

| Variable | Rule | Error Message |
|----------|------|---------------|
| `default_algorithm` | Must be one of: AES_128, AES_192, AES_256 | "The default_algorithm must be one of: AES_128, AES_192, AES_256." |
| `rotation_period` | Must be valid duration string or null | "The rotation_period must be a valid duration string (e.g., '8760h', '24h', '30m') or null to disable rotation." |
| `name` | 1-63 chars, lowercase, numbers, hyphens only | "The name must be 1-63 characters long and contain only lowercase letters, numbers, and hyphens." |
| `folder_id` | 20 char alphanumeric string or null | "The folder_id must be a valid Yandex Cloud folder ID (20 character alphanumeric string) or null." |
| `description` | ≤ 256 characters or null | "The description must be 256 characters or less." |