# Function

FN_CalculateMaintenanceFailureImpact

---

# Function

FN_CalculateMaintenanceFailureImpact

---

# Purpose

Calculates the impact percentage of maintenance failures by comparing the downtime caused by failures with the total available operating period.

This KPI is used to evaluate how much production availability is affected by maintenance-related failures.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| FailureDowntime | REAL | Total downtime caused by failures (hours) |
| AvailableOperatingTime | REAL | Total available operating time (hours) |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Failure impact (%) |

---

# Formula

```text
FailureImpact =
(FailureDowntime /
AvailableOperatingTime)
× 100
```

---

# Logic

```text
IF FailureDowntime < 0.0 THEN

    Return := 0.0;

ELSIF AvailableOperatingTime <= 0.0 THEN

    Return := 0.0;

ELSIF FailureDowntime >= AvailableOperatingTime THEN

    Return := 100.0;

ELSE

    Return :=
        (FailureDowntime * 100.0)
        /
        AvailableOperatingTime;

END_IF;
```

---

# Rules

- AvailableOperatingTime shall be greater than zero.
- FailureDowntime shall be zero or greater.
- FailureDowntime shall not exceed AvailableOperatingTime.
- Division by zero shall be prevented.
- The returned value shall be limited to the range 0–100%.
- The function shall execute within a single PLC scan.
- The function shall not modify input parameters.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Failure impact (%) |
| No failure impact | 0.0 |
| Complete downtime | 100.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Equipment reliability analysis
- Maintenance KPI dashboards
- Production loss analysis
- Asset performance monitoring
- Reliability improvement studies
- OEE support calculations

---

# Used By

- FB_DiagnosticsManager
- FB_MaintenanceManager
- FB_SystemManager
- FB_ReportManager

---

# Test Cases

| Failure Downtime | Available Time | Expected |
|-----------------:|---------------:|---------:|
| 0 h | 100 h | 0% |
| 5 h | 100 h | 5% |
| 25 h | 100 h | 25% |
| 100 h | 100 h | 100% |
| 5 h | 0 h | 0% |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the failure impact percentage.

It does not:

- Detect equipment failures
- Identify failure causes
- Generate alarms
- Start recovery procedures
- Store failure history
- Control equipment operation

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateFailureRate.md
- FN_CalculateDowntime.md
- FN_CalculateEquipmentDowntime.md
- FB_DiagnosticsManager.md
- TEST_Functions.md

---

# Revision

Version 1.0