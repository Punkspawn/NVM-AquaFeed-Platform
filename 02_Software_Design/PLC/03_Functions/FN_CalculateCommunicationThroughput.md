# Function

FN_CalculateCommunicationThroughput

---

# Function

FN_CalculateCommunicationThroughput

---

# Purpose

Calculates the communication throughput by determining the number of successful communication transactions processed per second.

This KPI is used to evaluate PLC communication performance, Modbus network capacity, and overall communication efficiency.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| SuccessfulRequests | DINT | Number of successful communication requests |
| MeasurementTime | TIME | Measurement period |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Communication throughput (requests/second) |

---

# Formula

```text
CommunicationThroughput =
SuccessfulRequests /
MeasurementTimeSeconds
```

---

# Logic

```text
VAR
    MeasurementSeconds : REAL;
END_VAR

MeasurementSeconds :=
    TIME_TO_REAL(MeasurementTime) /
    1000.0;

IF SuccessfulRequests < 0 THEN

    Return := 0.0;

ELSIF MeasurementSeconds <= 0.0 THEN

    Return := 0.0;

ELSE

    Return :=
        REAL(SuccessfulRequests) /
        MeasurementSeconds;

END_IF;
```

---

# Rules

- SuccessfulRequests shall be zero or greater.
- MeasurementTime shall be greater than zero.
- Division by zero shall be prevented.
- The returned value represents successful requests per second.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Requests per second |
| SuccessfulRequests = 0 | 0.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Modbus performance monitoring
- Communication benchmarking
- PLC network diagnostics
- Ethernet performance analysis
- Communication KPI dashboards
- Capacity planning

---

# Used By

- FB_ModbusMaster
- FB_CommunicationManager
- FB_DiagnosticsManager
- FB_SystemManager
- FB_ReportManager

---

# Test Cases

| Successful Requests | Measurement Time | Expected |
|--------------------:|-----------------|---------:|
| 100 | T#10S | 10 req/s |
| 600 | T#1M | 10 req/s |
| 1800 | T#3M | 10 req/s |
| 0 | T#30S | 0 req/s |
| 100 | T#0S | 0 req/s |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the average communication throughput.

It does not:

- Measure network bandwidth
- Detect packet loss
- Retry failed requests
- Optimize communication scheduling
- Store communication history
- Generate communication reports

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateCommunicationLatency.md
- FN_CalculateCommunicationSuccessRate.md
- FN_CalculateCommunicationAvailability.md
- FB_CommunicationManager.md
- FB_ModbusMaster.md
- TEST_Functions.md

---

# Revision

Version 1.0