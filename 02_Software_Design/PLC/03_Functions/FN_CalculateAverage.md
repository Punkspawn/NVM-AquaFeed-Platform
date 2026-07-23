# Function

FN_CalculateAverage

---

# Purpose

Calculates the arithmetic mean of a collection of numeric values.

This function provides a standardized method for obtaining average values from measurements, helping to smooth short-term fluctuations for monitoring and reporting purposes.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| Sum | REAL | Sum of all values |
| Count | UINT | Number of values included in the sum |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Calculated average value |

---

# Formula

```text
Average = Sum / Count
```

---

# Logic

```text
IF Count = 0 THEN
    Return := 0.0;
ELSE
    Return := Sum / Count;
END_IF;
```

---

# Rules

- Count shall be greater than zero for a valid calculation.
- Division by zero shall be prevented.
- The function shall not modify any input values.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Count > 0 | Sum / Count |
| Count = 0 | 0.0 |

---

# Typical Usage

- Average blower speed
- Average motor current
- Average feed rate
- Average sensor values
- Production statistics
- Trend calculations

---

# Used By

- FB_ReportManager
- FB_RuntimeManager
- FB_HistoryManager
- FB_SystemManager
- FB_HMIManager

---

# Test Cases

| Sum | Count | Expected |
|----:|------:|---------:|
| 100 | 4 | 25 |
| 75 | 3 | 25 |
| 0 | 5 | 0 |
| 100 | 1 | 100 |
| 100 | 0 | 0 |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the arithmetic mean.

It does not:

- Store historical samples
- Filter abnormal values
- Weight measurements
- Validate sensor quality
- Perform moving average calculations

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_MapValue.md
- FN_CheckRange.md
- FB_ReportManager.md
- TEST_Functions.md

---

# Revision

Version 1.0