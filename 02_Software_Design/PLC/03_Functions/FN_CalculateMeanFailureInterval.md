# Function

FN_CalculateMeanFailureInterval

---

# Function

FN_CalculateMeanFailureInterval

---

# Purpose

Calculates the Mean Failure Interval (MFI), representing the average operating time between consecutive communication failures.

This KPI is used to evaluate communication system reliability and determine how frequently failures occur during normal operation.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| TotalOperatingTime | REAL | Total communication operating time (hours) |
| FailureCount | DINT | Number of communication failures |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Mean Failure Interval (hours) |

---

# Formula

```text
MeanFailureInterval =
TotalOperatingTime /
FailureCount
```

---

# Logic

```text
IF TotalOperatingTime < 0.0 THEN

    Return := 0.0;

ELSIF FailureCount <= 0 THEN

    Return := 0.0;

ELSE

    Return :=
        TotalOperatingTime /
        REAL(FailureCount);

END_IF;
```

---

# Rules

- FailureCount shall be greater than zero.
- TotalOperatingTime shall be zero or greater.
- Division by zero shall be prevented.
- The returned value shall be zero or greater.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Mean failure interval (hours) |
| No failures recorded | 0.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Communication reliability analysis
- Industrial Ethernet diagnostics
- Modbus network monitoring
- PLC communication KPI calculations
- Preventive maintenance planning
- Long-term reliability reporting

---

# Used By

- FB_CommunicationManager
- FB_DiagnosticsManager
- FB_SystemManager
- FB_ReportManager
- FB_SCADAInterface

---

# Test Cases

| Total Operating Time | Failure Count | Expected |
|---------------------:|--------------:|---------:|
| 1000 h | 10 | 100 h |
| 500 h | 5 | 100 h |
| 240 h | 8 | 30 h |
| 100 h | 0 | 0 h |
| -50 h | 5 | 0 h |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the Mean Failure Interval.

It does not:

- Detect communication failures
- Predict future failures
- Initiate recovery procedures
- Store failure history
- Generate maintenance schedules
- Produce diagnostic reports

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateMeanRecoveryTime.md
- FN_CalculateCommunicationReliability.md
- FN_CalculateNetworkAvailability.md
- FN_IsCommunicationHealthy.md
- FB_CommunicationManager.md
- TEST_Functions.md

---

# Revision

Version 1.0