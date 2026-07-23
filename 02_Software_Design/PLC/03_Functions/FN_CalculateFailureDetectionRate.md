# Function

FN_CalculateFailureDetectionRate

---

# Function

FN_CalculateFailureDetectionRate

---

# Purpose

Calculates the percentage of actual failures that were successfully detected by the diagnostic system.

This KPI is used to evaluate diagnostic capability, monitoring effectiveness, and fault detection performance.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| DetectedFailures | DINT | Number of failures detected by diagnostics |
| ActualFailures | DINT | Total number of actual failures |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Failure detection rate (%) |

---

# Formula

```text
FailureDetectionRate =
(DetectedFailures /
ActualFailures)
× 100
```

---

# Logic

```text
IF DetectedFailures < 0 THEN

    Return := 0.0;

ELSIF ActualFailures <= 0 THEN

    Return := 0.0;

ELSIF DetectedFailures >= ActualFailures THEN

    Return := 100.0;

ELSE

    Return :=
        (REAL(DetectedFailures) * 100.0)
        /
        REAL(ActualFailures);

END_IF;
```

---

# Rules

- ActualFailures shall be greater than zero.
- DetectedFailures shall be zero or greater.
- DetectedFailures shall not exceed ActualFailures.
- Division by zero shall be prevented.
- The returned value shall be limited to the range 0–100%.
- The function shall execute within a single PLC scan.
- The function shall not modify input parameters.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Failure detection rate (%) |
| All failures detected | 100.0 |
| No failures detected | 0.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- PLC diagnostic performance monitoring
- Alarm system evaluation
- Predictive maintenance analysis
- Fault detection improvement
- Reliability dashboards
- System health monitoring

---

# Used By

- FB_DiagnosticsManager
- FB_SystemManager
- FB_ReportManager
- FB_MaintenanceManager

---

# Test Cases

| Detected Failures | Actual Failures | Expected |
|------------------:|----------------:|---------:|
| 100 | 100 | 100% |
| 95 | 100 | 95% |
| 80 | 100 | 80% |
| 0 | 100 | 0% |
| 10 | 0 | 0% |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only diagnostic detection performance.

It does not:

- Detect faults automatically
- Generate alarms
- Classify failure types
- Store diagnostic history
- Perform fault recovery
- Control equipment

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateFailureSeverityIndex.md
- FN_CalculateFailureRecoveryEfficiency.md
- FN_IsCommunicationHealthy.md
- FB_DiagnosticsManager.md
- TEST_Functions.md

---

# Revision

Version 1.0