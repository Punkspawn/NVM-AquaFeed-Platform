# Function

FN_SelectActiveRecipe

---

# Purpose

Selects the active recipe from a list of available recipes based on the requested recipe number.

This function provides a standardized method for validating recipe selection before it is loaded by the Recipe Manager.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| RequestedRecipeID | UINT | Recipe requested by the operator or job |
| RecipeCount | UINT | Total number of configured recipes |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | UINT | Valid recipe number (0 indicates invalid selection) |

---

# Logic

```text
IF RequestedRecipeID = 0 THEN
    Return := 0;

ELSIF RequestedRecipeID > RecipeCount THEN
    Return := 0;

ELSE
    Return := RequestedRecipeID;

END_IF;
```

---

# Rules

- Recipe numbering shall start from **1**.
- Recipe **0** is reserved to indicate "no valid recipe selected."
- RequestedRecipeID shall not exceed the configured recipe count.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid recipe | RequestedRecipeID |
| Invalid recipe | 0 |

---

# Typical Usage

- Recipe selection
- HMI recipe loading
- Automatic job execution
- Recipe validation
- Startup checks
- Batch initialization

---

# Used By

- FB_RecipeManager
- FB_JobManager
- FB_FeedingControlManager
- FB_HMIManager
- FB_SystemManager

---

# Test Cases

| Requested | Recipe Count | Expected |
|-----------:|-------------:|---------:|
| 1 | 20 | 1 |
| 10 | 20 | 10 |
| 20 | 20 | 20 |
| 21 | 20 | 0 |
| 0 | 20 | 0 |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function only validates the requested recipe identifier.

It does not:

- Load recipe parameters
- Verify recipe contents
- Activate a feeding job
- Store the selected recipe
- Notify the HMI

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FB_RecipeManager.md
- FB_JobManager.md
- SYSTEM_SPECIFICATION.md
- TEST_Functions.md

---

# Revision

Version 1.0