# Function

FN_CalculateProcessPerformanceIndex

---

# Function

FN_CalculateProcessPerformanceIndex

---

# Purpose

Calculates the Process Performance Index (Ppk), which evaluates actual long-term process performance while considering both process centering and overall variation.

Unlike Cpk, Ppk reflects real production performance using long-term process variation.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| ProcessMean | REAL | Process mean value |
| UpperSpecificationLimit | REAL | Upper specification limit (USL) |
| LowerSpecificationLimit | REAL | Lower specification limit (LSL) |
| ProcessStandardDeviation | REAL | Overall process standard deviation |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Process Performance Index (Ppk) |

---

# Formula

```text
Ppu = (USL - ProcessMean) / (3 × ProcessStandardDeviation)

Ppl = (ProcessMean - LSL) / (3 × ProcessStandardDeviation)

Ppk = MIN(Ppu, Ppl)
```

---

# Logic

```text
IF ProcessStandardDeviation <= 0.0 THEN

    Return := 0.0;

ELSIF UpperSpecificationLimit <= LowerSpecificationLimit THEN

    Return := 0.0;

ELSE

    Ppu :=
        (UpperSpecificationLimit - ProcessMean)
        /
        (3.0 * ProcessStandardDeviation);

    Ppl :=
        (ProcessMean - LowerSpecificationLimit)
        /
        (3.0 * ProcessStandardDeviation);

    Return := MIN(Ppu, Ppl);

END_IF;
```

---

# Rules

- ProcessStandardDeviation shall be greater than zero.
- UpperSpecificationLimit shall be greater than LowerSpecificationLimit.
- Division by zero shall be prevented.
- The returned value may be negative if the process mean is outside the specification limits.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Ppk value |
| Invalid limits | 0.0 |
| Invalid standard deviation | 0.0 |

---

# Typical Usage

- Long-term process performance analysis
- Statistical Process Control (SPC)
- Manufacturing quality reporting
- Production performance monitoring
- Continuous improvement programs
- Quality KPI dashboards

---

# Used By

- FB_QualityManager
- FB_ReportManager
- FB_ProductionManager
- FB_SystemManager

---

# Test Cases

| Mean | USL | LSL | StdDev | Expected |
|-----:|----:|----:|-------:|---------:|
| 7 | 10 | 4 | 1 | 1.00 |
| 8 | 10 | 4 | 1 | 0.67 |
| 6 | 10 | 4 | 0.5 | 1.33 |
| 7 | 10 | 10 | 1 | 0.0 |
| 7 | 10 | 4 | 0 | 0.0 |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the Process Performance Index (Ppk).

It does not:

- Calculate Cp, Cpk or Pp
- Perform statistical sampling
- Store measurement history
- Generate SPC reports
- Analyze production trends
- Control manufacturing equipment

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateProcessCapabilityIndex.md
- FN_CalculateProcessPerformance.md
- FN_IsWithinTolerance.md
- FB_QualityManager.md
- TEST_Functions.md

---

# Revision

Version 1.0