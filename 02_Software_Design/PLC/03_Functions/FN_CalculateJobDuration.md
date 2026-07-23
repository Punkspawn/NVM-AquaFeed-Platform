# Function

FN_CalculateJobDuration

---

# Purpose

Calculates the elapsed duration of a feeding job based on its start and end timestamps.

This function provides a standardized method for determining job execution time for production statistics, reporting, performance analysis, and historical logging.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| StartTime | TIME | Job start timestamp |
| EndTime | TIME | Job end timestamp |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | TIME | Calculated job duration |

---

# Formula

```text
Duration = EndTime - StartTime
```

---

# Logic

```text
IF EndTime < StartTime THEN
    Return := T#0S;

ELSE
    Return := EndTime - StartTime;

END_IF;
```

---

# Rules

- EndTime shall be greater than or equal to StartTime.
- Invalid timestamps shall return `T#0S`.
- The function shall not modify input values.
- No persistent variables shall be used.
- The function shall execute within a single PLC scan.

---

# Return Value

| Condition | Return |
|-----------|--------|
| EndTime ≥ StartTime | Calculated duration |
| EndTime < StartTime | T#0S |

---

# Typical Usage

- Feeding cycle duration
- Batch execution time
- Production statistics
- Historical reports
- Operator performance analysis
- Daily operating summaries

---

# Used By

- FB_JobManager
- FB_ReportManager
- FB_RuntimeManager
- FB_HistoryManager
- FB_SystemManager

---

# Test Cases

| Start | End | Expected |
|-------|-----|----------|
| T#0S | T#10S | T#10S |
| T#15S | T#45S | T#30S |
| T#2M | T#5M | T#3M |
| T#10S | T#10S | T#0S |
| T#30S | T#10S | T#0S |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function only calculates the elapsed duration between two timestamps.

It does not:

- Start or stop timers
- Store runtime history
- Detect timeout conditions
- Log production events
- Calculate equipment utilization

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_TimeToSeconds.md
- FN_SecondsToTime.md
- FB_JobManager.md
- FB_ReportManager.md
- TEST_Functions.md

---

# Revision

Version 1.0