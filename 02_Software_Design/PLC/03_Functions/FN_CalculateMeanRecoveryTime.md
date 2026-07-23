# Function

FN_CalculateMeanRecoveryTime

---

# Function

FN_CalculateMeanRecoveryTime

---

# Purpose

Calculates the Mean Recovery Time (MRT), representing the average time required to restore communication after a communication failure.

This KPI is widely used to evaluate system maintainability and communication recovery performance.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| TotalRecoveryTime | REAL | Sum of all recovery durations (seconds) |
| RecoveryCount | DINT | Number of completed recovery events |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Mean Recovery Time (seconds) |

---

# Formula

```text
MeanRecoveryTime =
TotalRecoveryTime /
RecoveryCount
```

---

# Logic

```text
IF TotalRecoveryTime < 0.0 THEN

    Return := 0.0;

ELSIF RecoveryCount <= 0 THEN

    Return := 0.0;

ELSE

    Return :=
        TotalRecoveryTime /
        REAL(RecoveryCount);

END_IF;
```

---

# Rules

- RecoveryCount shall be greater than zero.
- TotalRecoveryTime shall be zero or greater.
- Division by zero shall be prevented.
- The returned value shall be zero or greater.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Mean recovery time (seconds) |
| No recovery events | 0.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Communication recovery analysis
- Industrial Ethernet diagnostics
- Modbus recovery monitoring
- PLC communication performance
- Reliability KPI calculations
- Preventive maintenance reporting

---

# Used By

- FB_CommunicationManager
- FB_DiagnosticsManager
- FB_SystemManager
- FB_ReportManager
- FB_SCADAInterface

---

# Test Cases

| Total Recovery Time | Recovery Count | Expected |
|--------------------:|---------------:|---------:|
| 100 s | 10 | 10 s |
| 75 s | 5 | 15 s |
| 18 s | 3 | 6 s |
| 50 s | 0 | 0 s |
| -5 s | 2 | 0 s |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the Mean Recovery Time.

It does not:

- Detect communication failures
- Initiate recovery procedures
- Log recovery events
- Generate maintenance reports
- Store historical statistics
- Predict future failures

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateNetworkDowntime.md
- FN_CalculateCommunicationAvailability.md
- FN_IsCommunicationHealthy.md
- FB_CommunicationManager.md
- FB_DiagnosticsManager.md
- TEST_Functions.md

---

# Revision

Version 1.0