# Function

FN_CalculateCommunicationLatency

---

# Function

FN_CalculateCommunicationLatency

---

# Purpose

Calculates the average communication latency for a communication channel by dividing the accumulated response time by the number of successful communication requests.

This function is used to evaluate the responsiveness of Modbus RTU/TCP networks, PLC communication performance, and overall system health.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| TotalResponseTime | TIME | Total accumulated response time |
| SuccessfulRequests | DINT | Number of successful communication requests |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | TIME | Average communication latency |

---

# Formula

```text
AverageLatency =
TotalResponseTime /
SuccessfulRequests
```

---

# Logic

```text
VAR
    AverageMilliseconds : DINT;
END_VAR

IF SuccessfulRequests <= 0 THEN

    Return := T#0MS;

ELSE

    AverageMilliseconds :=
        TIME_TO_DINT(TotalResponseTime) /
        SuccessfulRequests;

    Return :=
        DINT_TO_TIME(AverageMilliseconds);

END_IF;
```

---

# Rules

- SuccessfulRequests shall be greater than zero.
- TotalResponseTime shall be zero or greater.
- Division by zero shall be prevented.
- The returned value shall never be negative.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Average communication latency |
| SuccessfulRequests = 0 | T#0MS |
| Invalid inputs | T#0MS |

---

# Typical Usage

- Modbus RTU diagnostics
- Modbus TCP performance monitoring
- PLC communication statistics
- Network performance analysis
- Communication KPI dashboard
- Predictive maintenance

---

# Used By

- FB_ModbusMaster
- FB_CommunicationManager
- FB_DiagnosticsManager
- FB_SystemManager
- FB_ReportManager

---

# Test Cases

| Total Response Time | Successful Requests | Expected |
|--------------------|--------------------:|---------:|
| T#100MS | 10 | T#10MS |
| T#2S | 20 | T#100MS |
| T#5S | 5 | T#1S |
| T#0MS | 10 | T#0MS |
| T#1S | 0 | T#0MS |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the average communication latency.

It does not:

- Detect communication failures
- Retry communication requests
- Measure network bandwidth
- Generate communication alarms
- Store historical communication statistics
- Optimize communication scheduling

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateCommunicationAvailability.md
- FN_CalculateCommunicationSuccessRate.md
- FN_CalculateCommunicationErrorRate.md
- FB_CommunicationManager.md
- FB_ModbusMaster.md
- TEST_Functions.md

---

# Revision

Version 1.0