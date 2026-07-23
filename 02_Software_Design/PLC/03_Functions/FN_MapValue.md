# Function

FN_MapValue

---

# Purpose

Maps a value from one numerical range to another using linear interpolation.

Unlike `FN_ScaleAnalogValue`, this function is a general-purpose mathematical utility and is not limited to analog I/O applications. It can be used wherever proportional conversion between two ranges is required.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| InputValue | REAL | Value to convert |
| InputMin | REAL | Minimum input range |
| InputMax | REAL | Maximum input range |
| OutputMin | REAL | Minimum output range |
| OutputMax | REAL | Maximum output range |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Converted value |

---

# Formula

```text
Return =
((InputValue - InputMin)
/
(InputMax - InputMin))
*
(OutputMax - OutputMin)
+
OutputMin
```

---

# Logic

```text
IF InputMax = InputMin THEN
    Return := OutputMin;
ELSE
    Return :=
        ((InputValue - InputMin) /
        (InputMax - InputMin))
        *
        (OutputMax - OutputMin)
        +
        OutputMin;
END_IF;
```

---

# Rules

- Input range shall not have zero width.
- Output range may be increasing or decreasing.
- The function shall not modify any input values.
- The function shall return a deterministic result.
- No internal memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid ranges | Mapped value |
| Invalid input range | OutputMin |

---

# Typical Usage

- HMI slider conversion
- Percentage calculations
- Speed reference scaling
- Feed rate conversion
- Sensor normalization
- Parameter conversion

---

# Used By

- FB_HMIManager
- FB_RecipeManager
- FB_SystemManager
- FB_LineManager
- FB_Dosing

---

# Test Cases

| Input | In Min | In Max | Out Min | Out Max | Expected |
|------:|-------:|--------:|--------:|---------:|---------:|
| 0 | 0 | 100 | 0 | 1000 | 0 |
| 50 | 0 | 100 | 0 | 1000 | 500 |
| 100 | 0 | 100 | 0 | 1000 | 1000 |
| 25 | 0 | 100 | -50 | 50 | -25 |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function performs only mathematical range mapping.

It does not:

- Clamp the output to the destination range
- Validate engineering limits
- Filter measurement noise
- Detect sensor faults

If output limiting is required, `FN_LimitValue` should be applied after the mapping operation.

---

# Related Documents

- FN_ScaleAnalogValue.md
- FN_LimitValue.md
- FN_CheckRange.md
- TEST_Functions.md

---

# Revision

Version 1.0