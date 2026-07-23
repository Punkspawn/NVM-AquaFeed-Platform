# Function

FN_CalculateProcessPerformance

---

# Function

FN_CalculateProcessPerformance

---

# Purpose

Calculates the Process Performance Index (Pp), which evaluates overall process performance using the actual long-term process variation.

Unlike Process Capability (Cp), this calculation uses the overall process variation and reflects real production performance over time.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| UpperSpecificationLimit | REAL | Upper specification limit |
| LowerSpecificationLimit | REAL | Lower specification limit |
| ProcessStandardDeviation | REAL | Overall process standard deviation |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Process Performance Index (Pp) |

---

# Formula

```text
Pp =
(UpperSpecificationLimit -
LowerSpecificationLimit)
/
(6 × ProcessStandardDeviation)
```

---

# Logic

```text
IF ProcessStandardDeviation <= 0.0 THEN

    Return := 0.0;

ELSIF UpperSpecificationLimit <= LowerSpecificationLimit THEN

    Return := 0.0;

ELSE

    Return :=
        (UpperSpecificationLimit -
         LowerSpecificationLimit)
        /
        (6.0 * ProcessStandardDeviation);

END_IF;
```

---

# Rules

- ProcessStandardDeviation shall be greater than zero.
- UpperSpecificationLimit shall be greater than LowerSpecificationLimit.
- Division by zero shall be prevented.
- The returned value shall be zero or greater.
- The function shall execute within a single PLC scan.
- The function shall not modify input parameters.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Pp value |
| Invalid limits | 0.0 |
| Invalid standard deviation | 0.0 |

---

# Typical Usage

- Long-term process performance analysis
- Statistical Process Control (SPC)
- Manufacturing quality reporting
- Production performance monitoring
- Quality KPI dashboards
- Process improvement studies

---

# Used By

- FB_QualityManager
- FB_ReportManager
- FB_ProductionManager
- FB_SystemManager

---

# Test Cases

| USL | LSL | StdDev | Expected |
|----:|----:|-------:|---------:|
| 10 | 4 | 1 | 1.00 |
| 12 | 6 | 0.5 | 2.00 |
| 8 | 4 | 2 | 0.33 |
| 10 | 10 | 1 | 0.0 |
| 10 | 4 | 0 | 0.0 |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the Process Performance Index (Pp).

It does not:

- Calculate Ppk
- Calculate Cp or Cpk
- Store statistical samples
- Generate SPC charts
- Analyze trends
- Control production equipment

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateProcessCapability.md
- FN_CalculateQuality.md
- FN_CalculateDeviation.md
- FB_QualityManager.md
- TEST_Functions.md

---

# Revision

Version 1.0