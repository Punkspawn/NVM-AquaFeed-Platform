# Function

FN_CalculateProcessCapability

---

# Function

FN_CalculateProcessCapability

---

# Purpose

Calculates the Process Capability Index (Cp), which indicates how well a process fits within its specified tolerance limits.

This KPI is used to evaluate manufacturing process consistency and stability.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| UpperSpecificationLimit | REAL | Upper specification limit |
| LowerSpecificationLimit | REAL | Lower specification limit |
| StandardDeviation | REAL | Process standard deviation |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Process Capability Index (Cp) |

---

# Formula

```text
Cp =
(UpperSpecificationLimit -
LowerSpecificationLimit)
/
(6 × StandardDeviation)
```

---

# Logic

```text
IF StandardDeviation <= 0.0 THEN

    Return := 0.0;

ELSIF UpperSpecificationLimit <= LowerSpecificationLimit THEN

    Return := 0.0;

ELSE

    Return :=
        (UpperSpecificationLimit -
         LowerSpecificationLimit)
        /
        (6.0 * StandardDeviation);

END_IF;
```

---

# Rules

- StandardDeviation shall be greater than zero.
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
| Valid inputs | Cp value |
| Invalid limits | 0.0 |
| Invalid standard deviation | 0.0 |

---

# Typical Usage

- Process capability analysis
- Manufacturing quality control
- Statistical process control (SPC)
- Process improvement
- Quality KPI calculations
- Production reporting

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

This function calculates only the Process Capability Index (Cp).

It does not:

- Calculate Cpk
- Analyze production trends
- Perform statistical sampling
- Store measurement history
- Generate SPC charts
- Control manufacturing equipment

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateQuality.md
- FN_CalculateDeviation.md
- FN_IsWithinTolerance.md
- FB_QualityManager.md
- TEST_Functions.md

---

# Revision

Version 1.0