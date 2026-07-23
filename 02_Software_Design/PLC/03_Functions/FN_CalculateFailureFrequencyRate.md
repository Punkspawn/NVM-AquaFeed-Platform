# Function

FN_CalculateFailureFrequencyRate

---

# Function

FN_CalculateFailureFrequencyRate

---

# Purpose

Calculates the failure frequency rate by comparing the number of failures with the total number of operating cycles.

This KPI is used to evaluate equipment reliability independent of operating time and is suitable for repetitive industrial processes.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| FailureCount | DINT | Total number of detected failures |
| OperatingCycles | DINT | Total number of completed operating cycles |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Failure frequency rate (%) |

---

# Formula

```text
FailureFrequencyRate =
(FailureCount /
OperatingCycles)
× 100
```

---

# Logic

```text
IF FailureCount < 0 THEN

    Return := 0.0;

ELSIF OperatingCycles <= 0 THEN

    Return := 0.0;

ELSE

    Return :=
        (REAL(FailureCount) * 100.0)
        /
        REAL(OperatingCycles);

END_IF;
```

---

# Rules

- OperatingCycles shall be greater than zero.
- FailureCount shall be zero or greater.
- Division by zero shall be prevented.
- The returned value shall always be zero or greater.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Failure frequency rate (%) |
| No failures | 0.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Equipment reliability analysis
- Repetitive production systems
- Machine performance monitoring
- Preventive maintenance planning
- Reliability KPI dashboards
- Failure trend analysis

---

# Used By

- FB_DiagnosticsManager
- FB_MaintenanceManager
- FB_SystemManager
- FB_ReportManager

---

# Test Cases

| Failures | Cycles | Expected |
|---------:|-------:|---------:|
| 0 | 10000 | 0% |
| 10 | 10000 | 0.1% |
| 50 | 10000 | 0.5% |
| 100 | 10000 | 1% |
| 10 | 0 | 0% |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only failure frequency based on operating cycles.

It does not:

- Detect equipment failures
- Analyze failure causes
- Generate alarms
- Schedule maintenance
- Store failure history
- Control equipment operation

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateFailureRate.md
- FN_CalculateFailureFrequency.md
- FN_CalculateFailureImpact.md
- FB_DiagnosticsManager.md
- TEST_Functions.md

---

# Revision

Version 1.0