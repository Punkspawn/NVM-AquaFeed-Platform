# Function

FN_CalculateProcessSigmaLevel

---

# Function

FN_CalculateProcessSigmaLevel

---

# Purpose

Calculates the estimated process sigma level from the Process Capability Index (Cpk).

This function provides a quick estimation of process capability using the common industrial approximation:

Sigma Level = Cpk × 3

The function is intended for KPI reporting and continuous improvement monitoring.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| ProcessCapabilityIndex | REAL | Calculated Cpk value |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Estimated Sigma Level |

---

# Formula

```text
SigmaLevel =
ProcessCapabilityIndex × 3
```

---

# Logic

```text
IF ProcessCapabilityIndex <= 0.0 THEN

    Return := 0.0;

ELSE

    Return :=
        ProcessCapabilityIndex * 3.0;

END_IF;
```

---

# Rules

- ProcessCapabilityIndex shall be zero or greater.
- Negative values shall return 0.0.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid input | Estimated Sigma Level |
| Cpk = 0 | 0.0 |
| Invalid input | 0.0 |

---

# Typical Usage

- Six Sigma KPI calculations
- Manufacturing quality dashboards
- Process capability reporting
- Continuous improvement projects
- SPC reporting
- Quality performance monitoring

---

# Used By

- FB_QualityManager
- FB_ReportManager
- FB_SystemManager
- FB_ProductionManager

---

# Test Cases

| Cpk | Expected Sigma |
|----:|---------------:|
| 2.00 | 6.00 |
| 1.67 | 5.01 |
| 1.33 | 3.99 |
| 1.00 | 3.00 |
| 0.00 | 0.00 |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function provides an estimated Sigma Level based on the calculated Cpk.

It does not:

- Calculate Cpk
- Calculate defects per million opportunities (DPMO)
- Perform statistical sampling
- Store historical quality data
- Generate SPC reports
- Control manufacturing equipment

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateProcessCapability.md
- FN_CalculateProcessCapabilityIndex.md
- FN_CalculateProcessPerformanceIndex.md
- FB_QualityManager.md
- TEST_Functions.md

---

# Revision

Version 1.0