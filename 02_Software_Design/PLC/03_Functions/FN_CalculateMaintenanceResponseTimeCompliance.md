# Function

FN_CalculateMaintenanceResponseTimeCompliance

---

# Function

FN_CalculateMaintenanceResponseTimeCompliance

---

# Purpose

Calculates the percentage of maintenance requests that were responded to within the specified response time target.

This KPI is used to evaluate compliance with maintenance response time requirements and Service Level Agreements (SLAs).

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| CompliantResponses | DINT | Number of maintenance requests responded to within the target response time |
| TotalResponses | DINT | Total maintenance requests responded to |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Response time compliance (%) |

---

# Formula

```text
ResponseTimeCompliance =
(CompliantResponses /
TotalResponses)
× 100
```

---

# Logic

```text
IF TotalResponses <= 0 THEN

    Return := 0.0;

ELSIF CompliantResponses < 0 THEN

    Return := 0.0;

ELSIF CompliantResponses >= TotalResponses THEN

    Return := 100.0;

ELSE

    Return :=
        (REAL(CompliantResponses) * 100.0)
        /
        REAL(TotalResponses);

END_IF;
```

---

# Rules

- TotalResponses shall be greater than zero.
- CompliantResponses shall be zero or greater.
- CompliantResponses shall not exceed TotalResponses.
- Division by zero shall be prevented.
- The returned value shall be limited to the range 0–100%.
- The function shall execute within a single PLC scan.
- The function shall not modify input parameters.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Response time compliance (%) |
| All responses within target | 100.0 |
| No responses within target | 0.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- SLA compliance monitoring
- Maintenance KPI dashboards
- Maintenance performance reporting
- CMMS analytics
- Service quality monitoring
- Asset management reporting

---

# Used By

- FB_MaintenanceManager
- FB_ReportManager
- FB_SystemManager
- FB_DiagnosticsManager

---

# Test Cases

| Compliant Responses | Total Responses | Expected |
|--------------------:|----------------:|---------:|
| 100 | 100 | 100% |
| 95 | 100 | 95% |
| 80 | 100 | 80% |
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

This function calculates only response time compliance.

It does not:

- Measure actual response times
- Schedule maintenance work
- Assign technicians
- Record maintenance history
- Generate maintenance reports
- Execute maintenance operations

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateMaintenanceResponseRate.md
- FN_CalculateMaintenanceCompletionRate.md
- FN_CalculateMaintenanceCompliance.md
- FB_MaintenanceManager.md
- TEST_Functions.md

---

# Revision

Version 1.0