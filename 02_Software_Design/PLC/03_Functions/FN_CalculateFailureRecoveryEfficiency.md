# Function

FN_CalculateFailureRecoveryEfficiency

---

# Function

FN_CalculateFailureRecoveryEfficiency

---

# Purpose

Calculates the efficiency of failure recovery operations by comparing the target recovery time with the actual recovery time.

This KPI is used to evaluate how effectively the system restores operation after failures.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| TargetRecoveryTime | REAL | Target recovery duration (minutes) |
| ActualRecoveryTime | REAL | Actual recovery duration (minutes) |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Failure recovery efficiency (%) |

---

# Formula

```text
RecoveryEfficiency =
(TargetRecoveryTime /
ActualRecoveryTime)
× 100
```

---

# Logic

```text
IF TargetRecoveryTime < 0.0 THEN

    Return := 0.0;

ELSIF ActualRecoveryTime <= 0.0 THEN

    Return := 0.0;

ELSIF TargetRecoveryTime >= ActualRecoveryTime THEN

    Return := 100.0;

ELSE

    Return :=
        (TargetRecoveryTime * 100.0)
        /
        ActualRecoveryTime;

END_IF;
```

---

# Rules

- TargetRecoveryTime shall be zero or greater.
- ActualRecoveryTime shall be greater than zero.
- Division by zero shall be prevented.
- The returned value shall be limited to the range 0–100%.
- A value of 100% indicates recovery completed within target time.
- The function shall execute within a single PLC scan.
- The function shall not modify input parameters.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Recovery within target | 100.0 |
| Recovery slower than target | Calculated percentage |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Fault recovery analysis
- Maintenance performance monitoring
- Reliability KPI dashboards
- System availability reporting
- Preventive improvement studies
- Diagnostic performance evaluation

---

# Used By

- FB_DiagnosticsManager
- FB_MaintenanceManager
- FB_SystemManager
- FB_ReportManager

---

# Test Cases

| Target Time | Actual Time | Expected |
|------------:|------------:|---------:|
| 10 min | 10 min | 100% |
| 10 min | 20 min | 50% |
| 30 min | 60 min | 50% |
| 5 min | 5 min | 100% |
| 10 min | 0 min | 0% |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only failure recovery efficiency.

It does not:

- Detect failures
- Execute recovery procedures
- Restart equipment
- Store recovery history
- Generate alarms
- Control field devices

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateMeanRecoveryTime.md
- FN_CalculateFailureSeverityIndex.md
- FN_CalculateEquipmentAvailability.md
- FB_DiagnosticsManager.md
- TEST_Functions.md

---

# Revision

Version 1.0