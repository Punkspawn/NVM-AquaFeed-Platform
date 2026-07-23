# Function

FN_CalculateMaintenanceRequestClosureRate

---

# Function

FN_CalculateMaintenanceRequestClosureRate

---

# Purpose

Calculates the percentage of maintenance requests that have been successfully closed during a reporting period.

This KPI is used to evaluate maintenance execution efficiency and overall service completion performance.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| ClosedRequests | DINT | Number of maintenance requests successfully closed |
| TotalRequests | DINT | Total maintenance requests received |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Maintenance request closure rate (%) |

---

# Formula

```text
MaintenanceRequestClosureRate =
(ClosedRequests /
TotalRequests)
× 100
```

---

# Logic

```text
IF TotalRequests <= 0 THEN

    Return := 0.0;

ELSIF ClosedRequests < 0 THEN

    Return := 0.0;

ELSIF ClosedRequests >= TotalRequests THEN

    Return := 100.0;

ELSE

    Return :=
        (REAL(ClosedRequests) * 100.0)
        /
        REAL(TotalRequests);

END_IF;
```

---

# Rules

- TotalRequests shall be greater than zero.
- ClosedRequests shall be zero or greater.
- ClosedRequests shall not exceed TotalRequests.
- Division by zero shall be prevented.
- The returned value shall be limited to the range 0–100%.
- The function shall execute within a single PLC scan.
- The function shall not modify input parameters.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Maintenance request closure rate (%) |
| All requests closed | 100.0 |
| No requests closed | 0.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Maintenance KPI dashboards
- CMMS reporting
- Service performance monitoring
- Asset management reporting
- Maintenance department performance analysis
- Continuous improvement reporting

---

# Used By

- FB_MaintenanceManager
- FB_ReportManager
- FB_SystemManager
- FB_DiagnosticsManager

---

# Test Cases

| Closed Requests | Total Requests | Expected |
|----------------:|---------------:|---------:|
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

This function calculates only the maintenance request closure rate.

It does not:

- Create maintenance requests
- Assign maintenance personnel
- Schedule maintenance work
- Store maintenance history
- Generate maintenance reports
- Execute maintenance activities

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateMaintenanceCompletionRate.md
- FN_CalculateMaintenanceResponseRate.md
- FN_CalculateMaintenanceCompliance.md
- FB_MaintenanceManager.md
- TEST_Functions.md

---

# Revision

Version 1.0