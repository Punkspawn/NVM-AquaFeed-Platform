# Function

FN_CalculateCommunicationRetryRate

---

# Function

FN_CalculateCommunicationRetryRate

---

# Purpose

Calculates the percentage of communication requests that required one or more retry attempts before completing successfully.

This KPI is useful for identifying communication quality degradation before complete communication failures begin to occur.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| RetryRequests | DINT | Number of communication requests requiring retries |
| TotalRequests | DINT | Total communication requests |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Communication retry rate (%) |

---

# Formula

```text
CommunicationRetryRate =
(RetryRequests /
TotalRequests)
× 100
```

---

# Logic

```text
IF RetryRequests < 0 THEN

    Return := 0.0;

ELSIF TotalRequests <= 0 THEN

    Return := 0.0;

ELSIF RetryRequests >= TotalRequests THEN

    Return := 100.0;

ELSE

    Return :=
        (REAL(RetryRequests) * 100.0) /
        REAL(TotalRequests);

END_IF;
```

---

# Rules

- TotalRequests shall be greater than zero.
- RetryRequests shall be zero or greater.
- Division by zero shall be prevented.
- The returned value shall be limited to the range 0–100%.
- RetryRequests greater than TotalRequests shall return 100%.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Retry rate (%) |
| No retries required | 0.0 |
| Every request retried | 100.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Modbus communication diagnostics
- Network quality monitoring
- RS-485 communication analysis
- Ethernet reliability monitoring
- Predictive maintenance
- Communication KPI reporting

---

# Used By

- FB_ModbusMaster
- FB_CommunicationManager
- FB_SystemManager
- FB_DiagnosticsManager
- FB_ReportManager

---

# Test Cases

| Retry Requests | Total Requests | Expected |
|---------------:|---------------:|---------:|
| 0 | 1000 | 0% |
| 5 | 1000 | 0.5% |
| 20 | 1000 | 2% |
| 1000 | 1000 | 100% |
| 50 | 0 | 0% |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the retry percentage of communication requests.

It does not:

- Perform retry operations
- Detect communication failures
- Reset communication hardware
- Log communication events
- Generate communication alarms
- Store diagnostic statistics

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateCommunicationSuccessRate.md
- FN_CalculateCommunicationErrorRate.md
- FN_IsCommunicationHealthy.md
- FB_CommunicationManager.md
- FB_ModbusMaster.md
- TEST_Functions.md

---

# Revision

Version 1.0