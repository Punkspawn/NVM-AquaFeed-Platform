# Function

FN_CalculateIdleTime

---

# Function

FN_CalculateIdleTime

---

# Purpose

Calculates the idle time of equipment during the available production period.

Idle time represents the duration in which the equipment was powered and available but not actively producing or processing feed. This KPI is useful for identifying production inefficiencies and optimizing scheduling.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| AvailableTime | TIME | Total scheduled production time |
| OperatingTime | TIME | Total active operating time |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | TIME | Calculated idle time |

---

# Formula

```text
IdleTime =
AvailableTime -
OperatingTime
```

---

# Logic

```text
IF AvailableTime <= T#0S THEN
    Return := T#0S;

ELSIF OperatingTime >= AvailableTime THEN
    Return := T#0S;

ELSE
    Return :=
        AvailableTime -
        OperatingTime;

END_IF;
```

---

# Rules

- AvailableTime shall be zero or greater.
- OperatingTime shall be zero or greater.
- Idle time shall never be negative.
- If OperatingTime exceeds AvailableTime, the returned idle time shall be zero.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Calculated idle time |
| OperatingTime ≥ AvailableTime | T#0S |
| Invalid AvailableTime | T#0S |

---

# Typical Usage

- Equipment utilization analysis
- Production KPI calculations
- Daily operating reports
- Shift performance evaluation
- HMI statistics
- Capacity planning

---

# Used By

- FB_RuntimeManager
- FB_ReportManager
- FB_HistoryManager
- FB_SystemManager
- FB_StatisticsManager

---

# Test Cases

| Available Time | Operating Time | Expected |
|---------------|----------------|----------|
| T#10H | T#8H | T#2H |
| T#8H | T#8H | T#0S |
| T#6H | T#7H | T#0S |
| T#0S | T#0S | T#0S |
| T#12H | T#9H30M | T#2H30M |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only idle time.

It does not:

- Determine the cause of idle periods
- Distinguish planned and unplanned idle time
- Generate maintenance requests
- Calculate Overall Equipment Effectiveness (OEE)
- Store historical statistics
- Trigger alarms or notifications

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateDowntime.md
- FN_CalculateUtilization.md
- FN_CalculateEfficiency.md
- FB_RuntimeManager.md
- FB_ReportManager.md
- TEST_Functions.md

---

# Revision

Version 1.0