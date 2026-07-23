# Function

FN_IsRecipeValid

---

# Purpose

Validates whether a recipe is complete and suitable for execution.

This function performs a basic consistency check before a recipe is accepted by the Recipe Manager. It helps prevent feeding jobs from starting with incomplete or invalid recipe parameters.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| RecipeID | UINT | Recipe identifier |
| FeedAmount | REAL | Planned feed amount (kg) |
| FeedRate | REAL | Feeding rate (kg/min) |
| LineID | UINT | Assigned feeding line |
| Enabled | BOOL | Recipe enabled flag |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | BOOL | TRUE if the recipe is valid |

---

# Logic

```text
IF NOT Enabled THEN
    Return := FALSE;

ELSIF RecipeID = 0 THEN
    Return := FALSE;

ELSIF FeedAmount <= 0 THEN
    Return := FALSE;

ELSIF FeedRate <= 0 THEN
    Return := FALSE;

ELSIF LineID = 0 THEN
    Return := FALSE;

ELSE
    Return := TRUE;

END_IF;
```

---

# Rules

- Recipe ID shall be greater than zero.
- Feed amount shall be greater than zero.
- Feed rate shall be greater than zero.
- A valid feeding line shall be assigned.
- The recipe shall be enabled.
- The function shall not modify any input values.
- The function shall execute within a single PLC scan.

---

# Return Value

| Condition | Return |
|-----------|--------|
| All validation checks pass | TRUE |
| Any validation check fails | FALSE |

---

# Typical Usage

- Recipe loading
- Recipe editing
- Automatic job scheduling
- HMI validation
- Startup verification
- Batch preparation

---

# Used By

- FB_RecipeManager
- FB_JobManager
- FB_FeedingControlManager
- FB_HMIManager
- FB_SystemManager

---

# Test Cases

| RecipeID | Feed Amount | Feed Rate | Line | Enabled | Expected |
|----------:|------------:|----------:|-----:|---------|----------|
| 1 | 100 | 20 | 1 | TRUE | TRUE |
| 0 | 100 | 20 | 1 | TRUE | FALSE |
| 1 | 0 | 20 | 1 | TRUE | FALSE |
| 1 | 100 | 0 | 1 | TRUE | FALSE |
| 1 | 100 | 20 | 0 | TRUE | FALSE |
| 1 | 100 | 20 | 1 | FALSE | FALSE |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function performs only structural validation of recipe parameters.

It does not:

- Load recipe data
- Verify feed inventory
- Check equipment availability
- Reserve a feeding line
- Start a feeding job
- Save recipe changes

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FB_RecipeManager.md
- FB_JobManager.md
- FN_SelectActiveRecipe.md
- SYSTEM_SPECIFICATION.md
- TEST_Functions.md

---

# Revision

Version 1.0