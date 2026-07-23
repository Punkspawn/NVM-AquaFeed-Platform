# Function

FN_IsValueChanged

---

# Purpose

Determines whether two values differ by more than a specified deadband.

This function is intended to suppress insignificant fluctuations caused by sensor noise or measurement resolution, allowing Function Blocks to react only to meaningful value changes.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| PreviousValue | REAL | Previously recorded value |
| CurrentValue | REAL | Current measured value |
| Deadband | REAL | Minimum change required to be considered significant |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | BOOL | TRUE if the value has changed by more than the deadband |

---

# Formula

```text
ABS(CurrentValue - PreviousValue) > Deadband
```

---

# Logic

```text
IF Deadband < 0 THEN
    Return := FALSE;

ELSIF ABS(CurrentValue - PreviousValue) > Deadband THEN
    Return := TRUE;

ELSE
    Return := FALSE;
END_IF;
```

---

# Rules

- Deadband shall be zero or greater.
- A change equal to the deadband is **not** considered significant.
- The function shall not modify input values.
- No internal memory shall be used.
- The function shall execute within a single PLC scan.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Change > Deadband | TRUE |
| Change ≤ Deadband | FALSE |
| Deadband < 0 | FALSE |

---

# Typical Usage

- Analog input monitoring
- HMI value refresh optimization
- Sensor change detection
- Event logging
- Trend recording
- Communication data filtering

---

# Used By

- FB_HMIManager
- FB_AnalogInput
- FB_ReportManager
- FB_HistoryManager
- FB_SystemManager

---

# Test Cases

| Previous | Current | Deadband | Expected |
|----------:|--------:|---------:|----------|
| 100 | 100 | 1 | FALSE |
| 100 | 100.5 | 1 | FALSE |
| 100 | 101 | 1 | FALSE |
| 100 | 101.1 | 1 | TRUE |
| 100 | 98 | 1 | TRUE |
| 100 | 100 | -1 | FALSE |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function only determines whether a significant value change has occurred.

It does not:

- Store previous values
- Update historical records
- Filter analog signals
- Generate alarms
- Trigger communication events

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateAbsoluteDeviation.md
- FN_IsWithinTolerance.md
- FB_AnalogInput.md
- TEST_Functions.md

---

# Revision

Version 1.0