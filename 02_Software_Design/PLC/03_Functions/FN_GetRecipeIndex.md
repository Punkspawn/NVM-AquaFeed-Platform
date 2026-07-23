# Function

FN_GetRecipeIndex

---

# Purpose

Returns the internal array index corresponding to a given Recipe ID.

This function provides a standardized lookup mechanism for recipe storage and prevents direct indexing logic from being duplicated throughout the PLC software.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| RecipeID | UINT | Recipe identifier |
| RecipeCount | UINT | Total number of configured recipes |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | INT | Internal array index (-1 if not found) |

---

# Logic

```text
IF RecipeID = 0 THEN
    Return := -1;

ELSIF RecipeID > RecipeCount THEN
    Return := -1;

ELSE
    Return := RecipeID - 1;

END_IF;
```

---

# Rules

- Recipe IDs start from **1**.
- Internal array indexes start from **0**.
- Invalid Recipe IDs shall return **-1**.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid Recipe ID | Array index |
| Invalid Recipe ID | -1 |

---

# Typical Usage

- Recipe Manager
- Recipe loading
- Recipe editing
- Job scheduling
- HMI recipe selection
- Recipe validation

---

# Used By

- FB_RecipeManager
- FB_JobManager
- FB_HMIManager
- FB_SystemManager
- FB_FeedingControlManager

---

# Test Cases

| Recipe ID | Recipe Count | Expected |
|-----------:|-------------:|---------:|
| 1 | 50 | 0 |
| 10 | 50 | 9 |
| 50 | 50 | 49 |
| 51 | 50 | -1 |
| 0 | 50 | -1 |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function only converts a Recipe ID into an internal array index.

It does not:

- Read recipe data
- Validate recipe contents
- Allocate memory
- Load recipe parameters
- Activate recipes
- Modify recipe storage

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_SelectActiveRecipe.md
- FN_IsRecipeValid.md
- FB_RecipeManager.md
- FB_JobManager.md
- TEST_Functions.md

---

# Revision

Version 1.0