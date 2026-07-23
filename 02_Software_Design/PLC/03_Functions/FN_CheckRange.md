# Function

FN_CheckRange

---

# Purpose

Checks whether a value is within a specified minimum and maximum range.

This function is used throughout the AquaFeed PLC software to validate engineering values before they are processed by Function Blocks.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| Value | REAL | Value to validate |
| Minimum | REAL | Minimum allowed value |
| Maximum | REAL | Maximum allowed value |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | BOOL | TRUE if the value is within range |

---

# Logic

```text
IF Value < Minimum THEN
    Return := FALSE;

ELSIF Value > Maximum THEN
    Return := FALSE;

ELSE
    Return := TRUE;
END_IF;
```

---

# Rules

- Minimum shall be less than or equal to Maximum.
- Boundary values are considered valid.
- The function shall not modify any input value.
- The function shall always return a deterministic result.

---

# Return Value

| Result | Meaning |
|---------|----------|
| TRUE | Value is valid |
| FALSE | Value is outside permitted limits |

---

# Typical Usage

- Recipe validation
- Analog input validation
- Speed verification
- Feed quantity verification
- Runtime parameter validation
- Configuration checking

---

# Used By

- FB_RecipeManager
- FB_SystemManager
- FB_Dosing
- FB_Blower
- FB_LineManager
- FB_ModbusMaster

---

# Test Cases

| Value | Min | Max | Expected |
|-------:|----:|----:|----------|
| 10 | 0 | 20 | TRUE |
| 0 | 0 | 20 | TRUE |
| 20 | 0 | 20 | TRUE |
| -1 | 0 | 20 | FALSE |
| 21 | 0 | 20 | FALSE |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Related Documents

- TEST_Functions.md
- PLC_Programming_Guideline.md
- Coding_Standard.md

---

# Revision

Version 1.0