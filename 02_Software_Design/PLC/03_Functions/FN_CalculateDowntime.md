# Function

FN_CalculateDowntime

---

# Function

FN_CalculateDowntime

---

# Purpose

Calculates the total downtime of equipment or a production line by subtracting the operating time from the available production time.

This function provides a standardized downtime calculation for production analysis, maintenance reporting, and equipment performance monitoring.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| AvailableTime | TIME | Total scheduled production time |
| OperatingTime | TIME | Total time the equipment was operating |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | TIME | Calculated downtime |

---

# Formula

```text
Downtime =
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
- Downtime shall never be negative.
- If OperatingTime exceeds AvailableTime, the returned downtime shall be zero.
- The function shall not modify input values.
- The function shall execute within a single PLC scan.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Calculated downtime |
| OperatingTime ≥ AvailableTime | T#0S |
| Invalid AvailableTime | T#0S |

---

# Typical Usage

- Equipment downtime reporting
- Maintenance KPI calculations
- Production loss analysis
- Historical reporting
- HMI statistics
- Daily production summaries

---

# Used By

- FB_RuntimeManager
- FB_ReportManager
- FB_HistoryManager
- FB_SystemManager
- FB_MaintenanceManager

---

# Test Cases

| Available Time | Operating Time | Expected |
|---------------|----------------|----------|
| T#10H | T#8H | T#2H |
| T#8H | T#8H | T#0S |
| T#8H | T#9H | T#0S |
| T#0S | T#0S | T#0S |
| T#5H | T#2H30M | T#2H30M |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the total downtime.

It does not:

- Determine downtime causes
- Classify planned or unplanned downtime
- Generate maintenance events
- Calculate OEE
- Store historical data
- Trigger alarms

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateUtilization.md
- FN_CalculateEfficiency.md
- FB_RuntimeManager.md
- FB_ReportManager.md
- TEST_Functions.md

---

# Revision

Version 1.0