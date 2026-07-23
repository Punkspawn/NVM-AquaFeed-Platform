# Function

FN_CalculateMaintenanceFailureFrequency

---

# Function

FN_CalculateMaintenanceFailureFrequency

---

# Purpose

Calculates the frequency of maintenance-related failures by comparing the number of detected failures with the total operating period.

This KPI is used to evaluate equipment reliability and identify assets requiring reliability improvement actions.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| FailureCount | DINT | Number of maintenance-related failures |
| OperatingTime | REAL | Total operating time (hours) |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Failure frequency (failures/hour) |

---

# Formula

```text
FailureFrequency =
FailureCount /
OperatingTime
```

---

# Logic

```text
IF FailureCount < 0 THEN

    Return := 0.0;

ELSIF OperatingTime <= 0.0 THEN

    Return := 0.0;

ELSE

    Return :=
        REAL(FailureCount) /
        OperatingTime;

END_IF;
```

---

# Rules

- OperatingTime shall be greater than zero.
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
| Valid inputs | Failures per hour |
| No failures | 0.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Equipment reliability analysis
- Preventive maintenance planning
- Failure trend monitoring
- Asset performance dashboards
- Reliability KPI calculations
- Maintenance optimization

---

# Used By

- FB_MaintenanceManager
- FB_DiagnosticsManager
- FB_SystemManager
- FB_ReportManager

---

# Test Cases

| Failure Count | Operating Time | Expected |
|--------------:|---------------:|---------:|
| 0 | 1000 h | 0.0 |
| 10 | 1000 h | 0.01 |
| 5 | 500 h | 0.01 |
| 100 | 100 h | 1.0 |
| 10 | 0 h | 0.0 |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only failure frequency.

It does not:

- Detect failures
- Diagnose failure causes
- Generate alarms
- Schedule maintenance
- Store failure history
- Control equipment operation

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateFailureRate.md
- FN_CalculateMeanFailureInterval.md
- FN_CalculateMeanTimeBetweenFailures.md
- FB_DiagnosticsManager.md
- TEST_Functions.md

---

# Revision

Version 1.0