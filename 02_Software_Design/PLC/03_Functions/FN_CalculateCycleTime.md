# Function

FN_CalculateCycleTime

---

# Purpose

Calculates the total cycle time required to complete a feeding operation.

The cycle time includes all major process phases such as selector positioning, blower startup, feeding operation, and shutdown. This function provides a standardized estimate for scheduling, reporting, and production planning.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| PositioningTime | TIME | Time required for selector positioning |
| BlowerStartTime | TIME | Blower startup time |
| FeedingTime | TIME | Active feeding duration |
| ShutdownTime | TIME | Equipment shutdown time |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | TIME | Total calculated cycle time |

---

# Formula

```text
CycleTime =
PositioningTime +
BlowerStartTime +
FeedingTime +
ShutdownTime
```

---

# Logic

```text
Return :=
    PositioningTime +
    BlowerStartTime +
    FeedingTime +
    ShutdownTime;
```

---

# Rules

- All input times shall be zero or greater.
- Negative time values are not permitted.
- The function performs only arithmetic addition.
- The function shall not modify input values.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Sum of all phase durations |

---

# Typical Usage

- Feeding job planning
- Production scheduling
- Estimated completion time
- Performance analysis
- Batch reporting
- HMI cycle information

---

# Used By

- FB_JobManager
- FB_FeedingControlManager
- FB_ReportManager
- FB_RuntimeManager
- FB_SystemManager

---

# Test Cases

| Positioning | Blower | Feeding | Shutdown | Expected |
|------------|---------|----------|-----------|----------|
| T#10S | T#5S | T#5M | T#15S | T#5M30S |
| T#0S | T#0S | T#1M | T#0S | T#1M |
| T#20S | T#10S | T#10M | T#30S | T#11M |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the theoretical cycle duration.

It does not:

- Measure actual execution time
- Detect delays
- Monitor equipment performance
- Predict future cycle times
- Update production statistics
- Control process sequencing

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateJobDuration.md
- FN_CalculateFeedRate.md
- FB_JobManager.md
- FB_FeedingControlManager.md
- TEST_Functions.md

---

# Revision

Version 1.0