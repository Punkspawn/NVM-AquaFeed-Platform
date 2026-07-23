# Function

FN_CalculateProcessCapabilityIndex

---

# Function

FN_CalculateProcessCapabilityIndex

---

# Purpose

Calculates the Process Capability Index (Cpk), which measures how well a process is centered within its specification limits while considering process variation.

Unlike Cp, Cpk reflects both process capability and process centering.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| ProcessMean | REAL | Process mean value |
| UpperSpecificationLimit | REAL | Upper specification limit (USL) |
| LowerSpecificationLimit | REAL | Lower specification limit (LSL) |
| StandardDeviation | REAL | Process standard deviation |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Process Capability Index (Cpk) |

---

# Formula

```text
Cpu = (USL - ProcessMean) / (3 × StandardDeviation)

Cpl = (ProcessMean - LSL) / (3 × StandardDeviation)

Cpk = MIN(Cpu, Cpl)
```

---

# Logic

```text
IF StandardDeviation <= 0.0 THEN

    Return := 0.0;

ELSIF UpperSpecificationLimit <= LowerSpecificationLimit THEN

    Return := 0.0;

ELSE

    Cpu :=
        (UpperSpecificationLimit - ProcessMean)
        /
        (3.0 * StandardDeviation);

    Cpl :=
        (ProcessMean - LowerSpecificationLimit)
        /
        (3.0 * StandardDeviation);

    Return := MIN(Cpu, Cpl);

END_IF;
```

---

# Rules

- StandardDeviation shall be greater than zero.
- UpperSpecificationLimit shall be greater than LowerSpecificationLimit.
- ProcessMean should lie within the specification limits.
- Division by zero shall be prevented.
- The returned value may be negative if the process mean is outside the specification limits.
- The function shall execute within a single PLC scan.
- The function shall not modify input parameters.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Cpk value |
| Invalid limits | 0.0 |
| Invalid standard deviation | 0.0 |

---

# Typical Usage

- Statistical Process Control (SPC)
- Manufacturing quality analysis
- Process capability evaluation
- Continuous improvement studies
- Production KPI reporting
- Quality dashboards

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

This function calculates only the Process Capability Index (Cpk).

It does not:

- Calculate Cp or Pp
- Perform statistical sampling
- Store measurement history
- Generate SPC charts
- Analyze production trends
- Control manufacturing equipment

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateProcessCapability.md
- FN_CalculateProcessPerformance.md
- FN_IsWithinTolerance.md
- FB_QualityManager.md
- TEST_Functions.md

---

# Revision

Version 1.0