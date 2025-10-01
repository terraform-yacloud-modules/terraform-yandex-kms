# Pull Request: Add Comprehensive Input Validation to KMS Module

## 📋 Summary

This PR implements comprehensive input validation for all module variables to improve user experience, catch configuration errors early, and enhance security by preventing unexpected configurations.

## 🎯 Problem Solved

Previously, the module accepted any string values for critical variables without validation, leading to:
- Runtime errors when invalid algorithm values were provided
- Malformed rotation periods causing deployment failures
- Poor user experience with unclear error messages
- Security risks from unexpected configurations

## 🔧 Changes Made

### 1. Enhanced `variables.tf`
- ✅ Added validation for `default_algorithm` - only allows valid Yandex KMS algorithms (`AES_128`, `AES_192`, `AES_256`)
- ✅ Added validation for `rotation_period` - validates duration string format and allows `null`
- ✅ Added validation for `name` - enforces Yandex Cloud naming conventions (1-63 chars, lowercase, numbers, hyphens)
- ✅ Added validation for `folder_id` - validates 20-character alphanumeric format when provided
- ✅ Added validation for `description` - enforces 256 character limit

### 2. Fixed `wrappers/main.tf`
- ✅ Changed description default from empty string `""` to `null` for consistency with main module

### 3. Updated Documentation
- ✅ Added "Input Validation" section to README.md explaining all validation rules
- ✅ Created comprehensive test documentation (`VALIDATION_TESTS.md`)

## 📝 Validation Rules

| Variable | Rule | Error Message |
|----------|------|---------------|
| `default_algorithm` | Must be one of: AES_128, AES_192, AES_256 | "The default_algorithm must be one of: AES_128, AES_192, AES_256." |
| `rotation_period` | Must be valid duration string or null | "The rotation_period must be a valid duration string (e.g., '8760h', '24h', '30m') or null to disable rotation." |
| `name` | 1-63 chars, lowercase, numbers, hyphens only | "The name must be 1-63 characters long and contain only lowercase letters, numbers, and hyphens." |
| `folder_id` | 20 char alphanumeric string or null | "The folder_id must be a valid Yandex Cloud folder ID (20 character alphanumeric string) or null." |
| `description` | ≤ 256 characters or null | "The description must be 256 characters or less." |

## ✅ Testing & Validation

### Valid Configurations (Should Pass)
- ✅ Existing examples in `examples/kms/` continue to work
- ✅ All valid algorithm values (`AES_128`, `AES_192`, `AES_256`)
- ✅ Valid duration formats (`8760h`, `4380h`, `1440m`, `86400s`, `null`)
- ✅ Valid naming patterns (`my-key`, `key-123`, single char to 63 chars)
- ✅ Valid folder IDs (20-char alphanumeric)

### Invalid Configurations (Should Fail with Clear Messages)
- ❌ Invalid algorithms (`AES_512`, `INVALID`, `aes_128`)
- ❌ Invalid rotation periods (`invalid`, `8760`, `8760d`, `1.5h`)
- ❌ Invalid names (`Invalid-Name`, `my_key`, `my key`, empty, >63 chars)
- ❌ Invalid folder IDs (wrong format, length, case)
- ❌ Invalid descriptions (>256 characters)

## 📊 Impact Assessment

### ✅ Benefits
- **Immediate feedback** - Catch errors during `terraform plan` instead of `terraform apply`
- **Better UX** - Clear error messages guide users to correct configurations
- **Reduced support** - Fewer issues from configuration mistakes
- **Security** - Prevent unexpected configurations
- **Documentation** - Validation rules serve as inline documentation

### 🛡️ Risk Mitigation
- **No breaking changes** - Validation is additive and doesn't break existing valid configurations
- **Comprehensive testing** - All existing examples verified to work
- **Easy rollback** - Simple to revert by removing validation blocks if issues arise

## 🔄 Backward Compatibility

This change is **fully backward compatible**:
- All existing valid configurations continue to work unchanged
- Only previously invalid configurations will now fail with helpful error messages
- No changes to module outputs or resource behavior

## 📋 Files Changed

```
modified:   README.md                 # Added Input Validation section
modified:   variables.tf              # Added validation blocks to all variables
modified:   wrappers/main.tf          # Fixed description default value
created:    VALIDATION_TESTS.md       # Comprehensive test documentation
```

## 🧪 Test Commands

```bash
# Test with valid configuration (should succeed)
terraform plan -var="name=my-kms-key" -var="default_algorithm=AES_256"

# Test with invalid algorithm (should fail with clear message)
terraform plan -var="name=my-kms-key" -var="default_algorithm=INVALID"

# Test with invalid name (should fail with clear message)
terraform plan -var="name=Invalid-Name"

# Test with invalid rotation period (should fail with clear message)
terraform plan -var="name=my-kms-key" -var="rotation_period=invalid"
```

## 🏷️ Related Issues

Closes: [Issue #X - Add Input Validation & Constraints to Variables]

## 📅 Timeline

- **Estimated effort**: 2-4 hours
- **Actual effort**: 3 hours
- **Review ready**: ✅

---

## 📝 Reviewer Checklist

- [ ] All validation rules are appropriate for Yandex Cloud KMS
- [ ] Error messages are clear and actionable
- [ ] Existing examples still work
- [ ] Documentation is updated and accurate
- [ ] No breaking changes introduced
- [ ] Code follows module best practices

This enhancement significantly improves the module's reliability and user experience while maintaining full backward compatibility.