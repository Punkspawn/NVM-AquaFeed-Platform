# Function

FN_CalculateMaintenanceResponseRate

---

# Function

FN_CalculateMaintenanceResponseRate

---

# Purpose

Calculates the percentage of maintenance requests that received a response within the required response time.

This KPI is used to evaluate maintenance responsiveness, service quality, and maintenance team performance.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| OnTimeResponses | DINT | Number of maintenance requests responded to within the target time |
| TotalRequests | DINT | Total maintenance requests received |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Maintenance response rate (%) |

---

# Formula

```text
MaintenanceResponseRate =
(OnTimeResponses /
TotalRequests)
× 100
```

---

# Logic

```text
IF TotalRequests <= 0 THEN

    Return := 0.0;

ELSIF OnTimeResponses < 0 THEN

    Return := 0.0;

ELSIF OnTimeResponses >= TotalRequests THEN

    Return := 100.0;

ELSE

    Return :=
        (REAL(OnTimeResponses) * 100.0)
        /
        REAL(TotalRequests);

END_IF;
```

---

# Rules

- TotalRequests shall be greater than zero.
- OnTimeResponses shall be zero or greater.
- OnTimeResponses shall not exceed TotalRequests.
- Division by zero shall be prevented.
- The returned value shall be limited to the range 0–100%.
- The function shall execute within a single PLC scan.
- The function shall not modify input parameters.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Maintenance response rate (%) |
| All requests responded on time | 100.0 |
| No requests responded on time | 0.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Maintenance KPI dashboards
- Service Level Agreement (SLA) monitoring
- Maintenance performance reporting
- CMMS analytics
- Asset management systems
- Continuous improvement reporting

---

# Used By

- FB_MaintenanceManager
- FB_ReportManager
- FB_SystemManager
- FB_DiagnosticsManager

---

# Test Cases

| On-Time Responses | Total Requests | Expected |
|------------------:|---------------:|---------:|
| 100 | 100 | 100% |
| 92 | 100 | 92% |
| 75 | 100 | 75% |
| 0 | 100 | 0% |
| 10 | 0 | 0% |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the maintenance response rate.

It does not:

- Receive maintenance requests
- Assign technicians
- Schedule maintenance work
- Record maintenance history
- Generate maintenance reports
- Execute maintenance activities

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateMaintenanceWorkload.md
- FN_CalculateMaintenanceCompletionRate.md
- FN_CalculateMaintenanceCompliance.md
- FB_MaintenanceManager.md
- TEST_Functions.md

---

# Revision

Version 1.0