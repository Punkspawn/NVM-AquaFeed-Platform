# Function

FN_CalculateCommunicationErrorRate

---

# Function

FN_CalculateCommunicationErrorRate

---

# Purpose

Calculates the communication error rate by comparing the number of failed communication attempts with the total communication attempts.

This function provides a standardized KPI for evaluating the reliability of Modbus RTU/TCP, Ethernet, serial communication, and other industrial communication networks.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| FailedRequests | DINT | Number of failed communication requests |
| TotalRequests | DINT | Total communication requests |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Communication error rate (%) |

---

# Formula

```text
CommunicationErrorRate =
(FailedRequests /
TotalRequests)
× 100
```

---

# Logic

```text
IF FailedRequests < 0 THEN

    Return := 0.0;

ELSIF TotalRequests <= 0 THEN

    Return := 0.0;

ELSIF FailedRequests >= TotalRequests THEN

    Return := 100.0;

ELSE

    Return :=
        (REAL(FailedRequests) * 100.0) /
        REAL(TotalRequests);

END_IF;
```

---

# Rules

- TotalRequests shall be greater than zero.
- FailedRequests shall be zero or greater.
- Division by zero shall be prevented.
- The returned value shall be limited to the range 0–100%.
- FailedRequests greater than TotalRequests shall return 100%.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Communication error rate (%) |
| No communication errors | 0.0 |
| All requests failed | 100.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Modbus communication diagnostics
- Ethernet network monitoring
- Remote I/O diagnostics
- PLC communication statistics
- HMI communication health monitoring
- System reliability reporting

---

# Used By

- FB_ModbusMaster
- FB_CommunicationManager
- FB_SystemManager
- FB_HMIManager
- FB_ReportManager

---

# Test Cases

| Failed Requests | Total Requests | Expected |
|----------------:|---------------:|---------:|
| 0 | 1000 | 0% |
| 10 | 1000 | 1% |
| 25 | 500 | 5% |
| 100 | 100 | 100% |
| 50 | 0 | 0% |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the communication error rate.

It does not:

- Retry failed communication requests
- Detect communication timeout causes
- Reset communication interfaces
- Log communication events
- Generate communication alarms
- Store diagnostic history

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_IsCommunicationHealthy.md
- FN_CalculateCommunicationAvailability.md
- FN_CalculateFailureRate.md
- FB_CommunicationManager.md
- FB_ModbusMaster.md
- TEST_Functions.md

---

# Revision

Version 1.0