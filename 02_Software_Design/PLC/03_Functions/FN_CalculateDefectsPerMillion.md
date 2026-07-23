# Function

FN_CalculateDefectsPerMillion

---

# Function

FN_CalculateDefectsPerMillion

---

# Purpose

Calculates Defects Per Million Opportunities (DPMO), a standard Six Sigma quality metric that expresses the number of defects expected per one million opportunities.

This function is intended for production quality reporting and process improvement analysis.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| DefectCount | DINT | Total number of detected defects |
| OpportunityCount | DINT | Total number of defect opportunities |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Defects Per Million Opportunities (DPMO) |

---

# Formula

```text
DPMO =
(DefectCount /
OpportunityCount)
× 1,000,000
```

---

# Logic

```text
IF DefectCount < 0 THEN

    Return := 0.0;

ELSIF OpportunityCount <= 0 THEN

    Return := 0.0;

ELSE

    Return :=
        (REAL(DefectCount) * 1000000.0)
        /
        REAL(OpportunityCount);

END_IF;
```

---

# Rules

- OpportunityCount shall be greater than zero.
- DefectCount shall be zero or greater.
- Division by zero shall be prevented.
- The returned value shall always be zero or greater.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | DPMO |
| No defects | 0.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Six Sigma calculations
- Quality KPI reporting
- Manufacturing quality analysis
- Statistical Process Control (SPC)
- Continuous improvement projects
- Production performance dashboards

---

# Used By

- FB_QualityManager
- FB_ReportManager
- FB_ProductionManager
- FB_SystemManager

---

# Test Cases

| Defects | Opportunities | Expected |
|--------:|--------------:|---------:|
| 0 | 1000 | 0 |
| 1 | 1000 | 1000 |
| 5 | 10000 | 500 |
| 25 | 100000 | 250 |
| 10 | 0 | 0 |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the DPMO metric.

It does not:

- Calculate Sigma Level
- Calculate Cpk or Ppk
- Perform statistical analysis
- Store quality history
- Generate SPC charts
- Control production equipment

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateProcessSigmaLevel.md
- FN_CalculateQuality.md
- FN_CalculateRejectRate.md
- FB_QualityManager.md
- TEST_Functions.md

---

# Revision

Version 1.0