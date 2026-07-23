# Function

FN_RoundValue

---

# Purpose

Rounds a floating-point value to a specified number of decimal places.

This function provides a standardized method for formatting engineering values before displaying them on the HMI, storing reports, or comparing process values.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| Value | REAL | Value to round |
| Decimals | UINT | Number of decimal places |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Rounded value |

---

# Logic

```text
Factor := 10 ^ Decimals;

Return :=
REAL(
    ROUND(Value * Factor)
) / Factor;
```

---

# Rules

- Decimals shall be zero or greater.
- Negative decimal values are not permitted.
- The function shall not modify input values.
- The function shall execute within a single PLC scan.
- No internal memory shall be used.

---

# Return Value

| Input | Decimals | Return |
|------:|---------:|-------:|
| 12.3456 | 2 | 12.35 |
| 12.344 | 2 | 12.34 |
| 5.8 | 0 | 6 |
| 5.2 | 0 | 5 |

---

# Typical Usage

- HMI numeric display
- Engineering reports
- Recipe parameters
- Feed quantity display
- Analog measurement presentation
- Trend value formatting

---

# Used By

- FB_HMIManager
- FB_ReportManager
- FB_RecipeManager
- FB_SystemManager
- FB_HistoryManager

---

# Test Cases

| Value | Decimals | Expected |
|-------:|---------:|---------:|
| 10.1234 | 2 | 10.12 |
| 10.126 | 2 | 10.13 |
| 100.5 | 0 | 101 |
| 100.49 | 0 | 100 |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function performs only numerical rounding.

It does not:

- Validate engineering limits
- Format values as strings
- Apply measurement tolerances
- Perform unit conversions

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_MapValue.md
- FN_CalculatePercentage.md
- FB_HMIManager.md
- TEST_Functions.md

---

# Revision

Version 1.0