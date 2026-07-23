# Function

FN_CalculateFailureSeverityIndex

---

# Function

FN_CalculateFailureSeverityIndex

---

# Purpose

Calculates a failure severity index by comparing the actual failure impact value with the defined maximum acceptable impact level.

This KPI is used to classify equipment failure severity and support maintenance prioritization decisions.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| ActualFailureImpact | REAL | Calculated failure impact percentage |
| MaximumAcceptableImpact | REAL | Maximum acceptable failure impact percentage |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Failure severity index (%) |

---

# Formula

```text
FailureSeverityIndex =
(ActualFailureImpact /
MaximumAcceptableImpact)
× 100
```

---

# Logic

```text
IF ActualFailureImpact < 0.0 THEN

    Return := 0.0;

ELSIF MaximumAcceptableImpact <= 0.0 THEN

    Return := 0.0;

ELSE

    Return :=
        (ActualFailureImpact * 100.0)
        /
        MaximumAcceptableImpact;

END_IF;
```

---

# Rules

- MaximumAcceptableImpact shall be greater than zero.
- ActualFailureImpact shall be zero or greater.
- Division by zero shall be prevented.
- The returned value shall be zero or greater.
- Values greater than 100% indicate that the acceptable failure impact level has been exceeded.
- The function shall execute within a single PLC scan.
- The function shall not modify input parameters.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Failure severity index (%) |
| No failure impact | 0.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Maintenance prioritization
- Reliability analysis
- Failure classification
- Asset performance monitoring
- Maintenance dashboards
- Risk evaluation

---

# Used By

- FB_DiagnosticsManager
- FB_MaintenanceManager
- FB_SystemManager
- FB_ReportManager

---

# Test Cases

| Actual Impact | Maximum Impact | Expected |
|--------------:|---------------:|---------:|
| 0% | 10% | 0% |
| 5% | 10% | 50% |
| 10% | 10% | 100% |
| 20% | 10% | 200% |
| 5% | 0% | 0% |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the failure severity index.

It does not:

- Detect failures
- Determine failure causes
- Generate alarms
- Assign maintenance priority automatically
- Store failure history
- Control equipment operation

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateFailureRate.md
- FN_CalculateMaintenanceFailureImpact.md
- FN_CalculateDowntime.md
- FB_DiagnosticsManager.md
- TEST_Functions.md

---

# Revision

Version 1.0