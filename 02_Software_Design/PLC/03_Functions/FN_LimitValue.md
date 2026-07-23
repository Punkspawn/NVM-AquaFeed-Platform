# Function

FN_LimitValue

---

# Purpose

Limits a numeric value to a specified minimum and maximum range.

Unlike `FN_CheckRange`, which only verifies validity, this function automatically constrains the value to the nearest valid limit.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| Value | REAL | Value to be limited |
| Minimum | REAL | Minimum allowed value |
| Maximum | REAL | Maximum allowed value |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Limited value |

---

# Logic

```text
IF Value < Minimum THEN
    Return := Minimum;

ELSIF Value > Maximum THEN
    Return := Maximum;

ELSE
    Return := Value;
END_IF;
```

---

# Rules

- Minimum shall be less than or equal to Maximum.
- Returned value shall always remain inside the specified range.
- Inputs shall never be modified.
- The function shall execute deterministically within a single PLC scan.

---

# Return Value

| Condition | Returned Value |
|-----------|----------------|
| Value < Minimum | Minimum |
| Minimum ≤ Value ≤ Maximum | Value |
| Value > Maximum | Maximum |

---

# Typical Usage

- Blower speed limitation
- Dosing speed limitation
- Analog output scaling
- Feed quantity limitation
- Runtime parameter correction
- Operator parameter validation

---

# Used By

- FB_Blower
- FB_Dosing
- FB_RecipeManager
- FB_LineManager
- FB_SystemManager
- FB_ModbusMaster

---

# Test Cases

| Value | Min | Max | Expected |
|-------:|----:|----:|----------|
| -5 | 0 | 100 | 0 |
| 0 | 0 | 100 | 0 |
| 25 | 0 | 100 | 25 |
| 100 | 0 | 100 | 100 |
| 150 | 0 | 100 | 100 |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function is recommended whenever an operator-entered or communication-received value must remain within safe operating limits before being processed by equipment Function Blocks.

---

# Related Documents

- FN_CheckRange.md
- PLC_Programming_Guideline.md
- Coding_Standard.md
- TEST_Functions.md

---

# Revision

Version 1.0