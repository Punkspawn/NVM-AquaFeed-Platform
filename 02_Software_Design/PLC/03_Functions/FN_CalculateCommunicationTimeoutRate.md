# Function

FN_CalculateCommunicationTimeoutRate

---

# Function

FN_CalculateCommunicationTimeoutRate

---

# Purpose

Calculates the percentage of communication requests that failed due to timeout conditions.

This KPI helps evaluate communication responsiveness and identify overloaded or unstable communication networks.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| TimeoutCount | DINT | Number of communication timeout events |
| TotalRequests | DINT | Total communication requests |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Communication timeout rate (%) |

---

# Formula

```text
CommunicationTimeoutRate =
(TimeoutCount /
TotalRequests)
× 100
```

---

# Logic

```text
IF TimeoutCount < 0 THEN

    Return := 0.0;

ELSIF TotalRequests <= 0 THEN

    Return := 0.0;

ELSIF TimeoutCount >= TotalRequests THEN

    Return := 100.0;

ELSE

    Return :=
        (REAL(TimeoutCount) * 100.0) /
        REAL(TotalRequests);

END_IF;
```

---

# Rules

- TotalRequests shall be greater than zero.
- TimeoutCount shall be zero or greater.
- Division by zero shall be prevented.
- The returned value shall be limited to the range 0–100%.
- TimeoutCount shall not exceed TotalRequests.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Timeout rate (%) |
| No timeout events | 0.0 |
| All requests timed out | 100.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Modbus RTU timeout monitoring
- Ethernet communication diagnostics
- PLC communication performance analysis
- Network health monitoring
- Communication KPI dashboards
- Preventive maintenance

---

# Used By

- FB_ModbusMaster
- FB_CommunicationManager
- FB_DiagnosticsManager
- FB_SystemManager
- FB_ReportManager

---

# Test Cases

| Timeout Count | Total Requests | Expected |
|--------------:|---------------:|---------:|
| 0 | 1000 | 0% |
| 10 | 1000 | 1% |
| 50 | 1000 | 5% |
| 1000 | 1000 | 100% |
| 10 | 0 | 0% |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the communication timeout rate.

It does not:

- Detect timeout causes
- Retry failed requests
- Reset communication hardware
- Log timeout events
- Generate communication alarms
- Store communication statistics

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateCommunicationErrorRate.md
- FN_CalculateCommunicationLatency.md
- FN_IsCommunicationHealthy.md
- FB_CommunicationManager.md
- FB_ModbusMaster.md
- TEST_Functions.md

---

# Revision

Version 1.0