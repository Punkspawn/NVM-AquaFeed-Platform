# Function

FN_CalculateCommunicationLoad

---

# Function

FN_CalculateCommunicationLoad

---

# Purpose

Calculates the communication bus load as a percentage of the maximum allowable communication capacity.

This function is used to monitor Modbus network utilization, identify overloaded communication channels, and support communication performance optimization.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| CurrentRequestRate | REAL | Current communication request rate (requests/second) |
| MaximumRequestRate | REAL | Maximum supported communication request rate (requests/second) |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Communication load (%) |

---

# Formula

```text
CommunicationLoad =
(CurrentRequestRate /
MaximumRequestRate)
× 100
```

---

# Logic

```text
IF CurrentRequestRate < 0.0 THEN

    Return := 0.0;

ELSIF MaximumRequestRate <= 0.0 THEN

    Return := 0.0;

ELSIF CurrentRequestRate >= MaximumRequestRate THEN

    Return := 100.0;

ELSE

    Return :=
        (CurrentRequestRate * 100.0) /
        MaximumRequestRate;

END_IF;
```

---

# Rules

- MaximumRequestRate shall be greater than zero.
- CurrentRequestRate shall be zero or greater.
- Division by zero shall be prevented.
- The returned value shall be limited to the range 0–100%.
- Values exceeding the maximum supported capacity shall return 100%.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Communication load (%) |
| CurrentRequestRate = 0 | 0.0 |
| CurrentRequestRate ≥ MaximumRequestRate | 100.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Modbus RTU bus load monitoring
- Ethernet communication monitoring
- PLC communication diagnostics
- Communication capacity planning
- HMI communication dashboards
- Performance optimization

---

# Used By

- FB_CommunicationManager
- FB_ModbusMaster
- FB_SystemManager
- FB_DiagnosticsManager
- FB_ReportManager

---

# Test Cases

| Current Rate | Maximum Rate | Expected |
|-------------:|-------------:|---------:|
| 20 req/s | 100 req/s | 20% |
| 75 req/s | 100 req/s | 75% |
| 100 req/s | 100 req/s | 100% |
| 120 req/s | 100 req/s | 100% |
| 20 req/s | 0 req/s | 0% |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the communication load percentage.

It does not:

- Schedule communication requests
- Prioritize Modbus transactions
- Retry failed communications
- Detect communication failures
- Store communication statistics
- Generate communication reports

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateCommunicationThroughput.md
- FN_CalculateCommunicationLatency.md
- FN_CalculateCommunicationAvailability.md
- FB_CommunicationManager.md
- FB_ModbusMaster.md
- TEST_Functions.md

---

# Revision

Version 1.0