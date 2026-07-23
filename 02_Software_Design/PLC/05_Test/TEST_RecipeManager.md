# TEST_RecipeManager

---

# Purpose

Verify the correct operation of FB_RecipeManager.

This test validates recipe creation, loading, validation, editing, deletion and execution authorization.

---

# Preconditions

- PLC powered on
- System Ready
- User logged in with Recipe Edit permission
- No active production
- No active alarms

---

# Test Cases

## TC-001 Load Recipe

### Procedure

1. Select Recipe 01.
2. Press Load.

### Expected Result

- Recipe loaded successfully.
- ActiveRecipeID updated.
- Loaded = TRUE.

Result

□ PASS

□ FAIL

---

## TC-002 Validate Recipe

### Procedure

1. Load Recipe 01.
2. Execute validation.

### Expected Result

- Validation completed.
- Valid = TRUE.
- No alarms generated.

Result

□ PASS

□ FAIL

---

## TC-003 Invalid Feed Quantity

### Procedure

1. Set FeedAmountKg to 0.
2. Validate recipe.

### Expected Result

- Validation fails.
- Valid = FALSE.
- Alarm generated.

Result

□ PASS

□ FAIL

---

## TC-004 Invalid Blower Speed

### Procedure

1. Set blower speed above maximum limit.
2. Validate recipe.

### Expected Result

- Validation fails.
- Alarm generated.
- Recipe rejected.

Result

□ PASS

□ FAIL

---

## TC-005 Save Recipe

### Procedure

1. Modify a valid recipe.
2. Save changes.

### Expected Result

- Recipe stored successfully.
- Saved = TRUE.
- Recipe ID unchanged.

Result

□ PASS

□ FAIL

---

## TC-006 Delete Recipe

### Procedure

1. Select an unused recipe.
2. Delete recipe.

### Expected Result

- Recipe removed.
- Recipe list updated.
- No orphan references.

Result

□ PASS

□ FAIL

---

## TC-007 Delete Active Recipe

### Procedure

1. Load a recipe.
2. Attempt deletion.

### Expected Result

- Delete request rejected.
- Alarm generated.
- Active recipe preserved.

Result

□ PASS

□ FAIL

---

## TC-008 Modify During Production

### Procedure

1. Start production.
2. Attempt recipe modification.

### Expected Result

- Modification denied.
- Production unaffected.
- Alarm generated.

Result

□ PASS

□ FAIL

---

## TC-009 Unauthorized Access

### Procedure

1. Login as Operator.
2. Attempt recipe modification.

### Expected Result

- Operation denied.
- Alarm generated.
- Recipe unchanged.

Result

□ PASS

□ FAIL

---

## TC-010 Maximum Recipe Limits

### Procedure

1. Create recipe using maximum permitted values.
2. Validate.

### Expected Result

- Validation successful.
- Recipe accepted.
- No overflow or calculation errors.

Result

□ PASS

□ FAIL

---

# Acceptance Criteria

- Only valid recipes shall be accepted.
- Active recipes shall not be modified during production.
- Unauthorized users shall not modify recipes.
- Recipe validation shall detect all parameter violations.
- Recipe data integrity shall be maintained.
- All test cases shall pass successfully.

---

# Tested Module

FB_RecipeManager

---

# Related Modules

- FB_FeedingControlManager
- FB_JobManager
- FB_UserManager
- FB_AlarmManager
- AquaFeed Manager

---

# Revision

Version 1.0