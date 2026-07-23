# Function

FN_CalculateMeanTimeToRepair

---

# Function

FN_CalculateMeanTimeToRepair

---

# Purpose

Calculates the **Mean Time To Repair (MTTR)** for equipment or the overall feeding system.

MTTR is a maintenance KPI that represents the average time required to restore equipment to normal operation after a failure. It is used to evaluate maintenance performance and equipment maintainability.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| TotalRepairTime | TIME | Total accumulated repair time |
| RepairCount | UINT | Number of completed repairs |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | TIME | Mean Time To Repair (MTTR) |

---

# Formula

```text
MTTR =
TotalRepairTime
/
RepairCount
```

---

# Logic

```text
IF RepairCount = 0 THEN
    Return := T#0S;

ELSIF TotalRepairTime <= T#0S THEN
    Return := T#0S;

ELSE
    Return :=
        DINT_TO_TIME(
            TIME_TO_DINT(TotalRepairTime) /
            UINT_TO_DINT(RepairCount)
        );

END_IF;
```

---

# Rules

- TotalRepairTime shall be zero or greater.
- RepairCount shall be zero or greater.
- Division by zero shall be prevented.
- If no repairs have been completed, the function shall return T#0S.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | MTTR |
| RepairCount = 0 | T#0S |
| TotalRepairTime ≤ T#0S | T#0S |

---

# Typical Usage

- Maintenance KPI calculations
- Reliability analysis
- Service performance evaluation
- Historical maintenance reports
- Maintenance dashboard
- Equipment comparison

---

# Used By

- FB_MaintenanceManager
- FB_ReportManager
- FB_HistoryManager
- FB_RuntimeManager
- FB_StatisticsManager

---

# Test Cases

| Total Repair Time | Repair Count | Expected |
|------------------|-------------:|----------|
| T#10H | 5 | T#2H |
| T#90M | 3 | T#30M |
| T#0S | 2 | T#0S |
| T#5H | 0 | T#0S |
| T#12H | 1 | T#12H |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the Mean Time To Repair (MTTR).

It does not:

- Record repair events
- Identify repair causes
- Schedule maintenance activities
- Predict future repair durations
- Store maintenance history
- Generate maintenance work orders

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateMeanTimeBetweenFailures.md
- FN_CalculateFailureRate.md
- FB_MaintenanceManager.md
- FB_ReportManager.md
- TEST_Functions.md

---

# Revision

Version 1.0