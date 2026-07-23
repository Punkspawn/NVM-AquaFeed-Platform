# Function

FN_CalculateCommunicationStability

---

# Function

FN_CalculateCommunicationStability

---

# Purpose

Calculates the communication stability index by comparing successful communication requests that completed without retries to the total number of successful communication requests.

This KPI measures how consistently devices communicate without requiring retransmissions and provides an indication of communication quality beyond simple availability.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| StableRequests | DINT | Successful requests completed without retries |
| SuccessfulRequests | DINT | Total successful communication requests |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Communication stability (%) |

---

# Formula

```text
CommunicationStability =
(StableRequests /
SuccessfulRequests)
× 100
```

---

# Logic

```text
IF StableRequests < 0 THEN

    Return := 0.0;

ELSIF SuccessfulRequests <= 0 THEN

    Return := 0.0;

ELSIF StableRequests >= SuccessfulRequests THEN

    Return := 100.0;

ELSE

    Return :=
        (REAL(StableRequests) * 100.0) /
        REAL(SuccessfulRequests);

END_IF;
```

---

# Rules

- SuccessfulRequests shall be greater than zero.
- StableRequests shall be zero or greater.
- Division by zero shall be prevented.
- StableRequests shall not exceed SuccessfulRequests.
- The returned value shall be limited to the range 0–100%.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Communication stability (%) |
| All requests completed without retries | 100.0 |
| No stable requests | 0.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Communication quality monitoring
- Modbus RTU diagnostics
- Ethernet communication analysis
- RS-485 bus performance evaluation
- Predictive maintenance
- Communication KPI dashboards

---

# Used By

- FB_CommunicationManager
- FB_ModbusMaster
- FB_DiagnosticsManager
- FB_SystemManager
- FB_ReportManager

---

# Test Cases

| Stable Requests | Successful Requests | Expected |
|----------------:|--------------------:|---------:|
| 1000 | 1000 | 100% |
| 990 | 1000 | 99% |
| 950 | 1000 | 95% |
| 0 | 1000 | 0% |
| 100 | 0 | 0% |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the communication stability index.

It does not:

- Detect communication failures
- Retry failed communications
- Measure communication latency
- Calculate communication throughput
- Store communication statistics
- Generate communication diagnostics

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateCommunicationEfficiency.md
- FN_CalculateCommunicationRetryRate.md
- FN_CalculateCommunicationSuccessRate.md
- FN_IsCommunicationHealthy.md
- FB_CommunicationManager.md
- TEST_Functions.md

---

# Revision

Version 1.0