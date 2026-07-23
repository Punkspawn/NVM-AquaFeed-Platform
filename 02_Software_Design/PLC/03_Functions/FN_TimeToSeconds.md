# Function

FN_TimeToSeconds

---

# Purpose

Converts a PLC `TIME` value into an integer value expressed in seconds.

This function provides a standardized method for presenting timer values on the HMI, storing runtime statistics, and performing engineering calculations using whole seconds.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| TimeValue | TIME | PLC time value |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | DINT | Time expressed in seconds |

---

# Formula

```text
Seconds = TIME_TO_DINT(TimeValue) / 1000
```

---

# Logic

```text
IF TimeValue <= T#0S THEN
    Return := 0;
ELSE
    Return := TIME_TO_DINT(TimeValue) / 1000;
END_IF;
```

---

# Rules

- Zero shall return `0`.
- Negative time values, if supported by the PLC platform, shall return `0`.
- Fractional seconds shall be truncated.
- The function shall not modify the input value.
- Execution shall complete within a single PLC scan.

---

# Return Value

| Input | Output |
|-------|--------|
| T#0S | 0 |
| T#1S | 1 |
| T#15S | 15 |
| T#1M | 60 |
| T#5M30S | 330 |

---

# Typical Usage

- Runtime statistics
- HMI display values
- Recipe reporting
- Job duration reporting
- Alarm event logging
- Historical data storage

---

# Used By

- FB_ReportManager
- FB_RuntimeManager
- FB_JobManager
- FB_SystemManager
- FB_HMIManager

---

# Test Cases

| Input | Expected |
|-------|----------|
| T#0S | 0 |
| T#10S | 10 |
| T#59S | 59 |
| T#1M | 60 |
| T#10M | 600 |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function performs only a data type conversion.

It does not:

- Start or stop timers
- Validate process timing
- Detect timeout conditions
- Store runtime statistics

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_SecondsToTime.md
- FB_RuntimeManager.md
- FB_ReportManager.md
- TEST_Functions.md

---

# Revision

Version 1.0