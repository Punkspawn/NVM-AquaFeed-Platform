# Function

FN_CalculateCommunicationEfficiency

---

# Function

FN_CalculateCommunicationEfficiency

---

# Purpose

Calculates the overall communication efficiency by comparing successful communication requests with the total communication attempts, including retries.

Unlike Communication Success Rate, this KPI reflects the impact of retry operations on overall communication performance.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| SuccessfulRequests | DINT | Number of successful communication requests |
| TotalAttempts | DINT | Total communication attempts including retries |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Communication efficiency (%) |

---

# Formula

```text
CommunicationEfficiency =
(SuccessfulRequests /
TotalAttempts)
× 100
```

---

# Logic

```text
IF SuccessfulRequests < 0 THEN

    Return := 0.0;

ELSIF TotalAttempts <= 0 THEN

    Return := 0.0;

ELSIF SuccessfulRequests >= TotalAttempts THEN

    Return := 100.0;

ELSE

    Return :=
        (REAL(SuccessfulRequests) * 100.0) /
        REAL(TotalAttempts);

END_IF;
```

---

# Rules

- TotalAttempts shall be greater than zero.
- SuccessfulRequests shall be zero or greater.
- Division by zero shall be prevented.
- The returned value shall be limited to the range 0–100%.
- SuccessfulRequests shall not exceed TotalAttempts.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Communication efficiency (%) |
| All attempts successful | 100.0 |
| No successful attempts | 0.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Communication KPI calculations
- Modbus RTU/TCP diagnostics
- PLC network performance analysis
- Retry efficiency monitoring
- System performance dashboards
- Reliability reporting

---

# Used By

- FB_CommunicationManager
- FB_ModbusMaster
- FB_DiagnosticsManager
- FB_SystemManager
- FB_ReportManager

---

# Test Cases

| Successful Requests | Total Attempts | Expected |
|--------------------:|---------------:|---------:|
| 1000 | 1000 | 100% |
| 980 | 1000 | 98% |
| 900 | 1000 | 90% |
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

This function calculates only overall communication efficiency.

It does not:

- Retry failed communications
- Detect communication failures
- Measure communication latency
- Optimize polling intervals
- Store communication statistics
- Generate diagnostic reports

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateCommunicationSuccessRate.md
- FN_CalculateCommunicationErrorRate.md
- FN_CalculateCommunicationRetryRate.md
- FN_CalculateCommunicationAvailability.md
- FB_CommunicationManager.md
- TEST_Functions.md

---

# Revision

Version 1.0