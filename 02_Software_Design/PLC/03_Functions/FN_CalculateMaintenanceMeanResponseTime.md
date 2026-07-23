# Function

FN_CalculateMaintenanceMeanResponseTime

---

# Function

FN_CalculateMaintenanceMeanResponseTime

---

# Purpose

Calculates the average response time for maintenance requests by dividing the total response time by the number of maintenance requests.

This KPI is used to evaluate maintenance responsiveness and service performance.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| TotalResponseTime | REAL | Total accumulated response time (hours) |
| RequestCount | DINT | Number of maintenance requests |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Mean response time (hours) |

---

# Formula

```text
MeanResponseTime =
TotalResponseTime /
RequestCount
```

---

# Logic

```text
IF TotalResponseTime < 0.0 THEN

    Return := 0.0;

ELSIF RequestCount <= 0 THEN

    Return := 0.0;

ELSE

    Return :=
        TotalResponseTime /
        REAL(RequestCount);

END_IF;
```

---

# Rules

- RequestCount shall be greater than zero.
- TotalResponseTime shall be zero or greater.
- Division by zero shall be prevented.
- The returned value shall always be zero or greater.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Average response time |
| No requests | 0.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Maintenance KPI calculations
- SLA performance monitoring
- Service response analysis
- Reliability reporting
- Maintenance dashboards
- CMMS integration

---

# Used By

- FB_MaintenanceManager
- FB_ReportManager
- FB_DiagnosticsManager
- FB_SystemManager

---

# Test Cases

| Total Response Time | Requests | Expected |
|--------------------:|---------:|---------:|
| 100 h | 10 | 10 h |
| 50 h | 5 | 10 h |
| 24 h | 8 | 3 h |
| 0 h | 10 | 0 h |
| 10 h | 0 | 0 h |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the average maintenance response time.

It does not:

- Measure response times
- Receive maintenance requests
- Assign technicians
- Store maintenance history
- Generate reports
- Execute maintenance activities

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateMaintenanceResponseRate.md
- FN_CalculateMaintenanceResponseTimeCompliance.md
- FN_CalculateMeanRecoveryTime.md
- FB_MaintenanceManager.md
- TEST_Functions.md

---

# Revision

Version 1.0