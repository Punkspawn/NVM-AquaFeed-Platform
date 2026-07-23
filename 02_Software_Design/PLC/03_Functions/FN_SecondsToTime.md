# Function

FN_SecondsToTime

---

# Purpose

Converts a time value expressed in seconds into the PLC `TIME` data type.

This function standardizes time conversion throughout the AquaFeed Platform, ensuring that operator-entered values and configuration parameters can be consistently used by PLC timers and Function Blocks.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| Seconds | DINT | Time value in seconds |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | TIME | Equivalent PLC TIME value |

---

# Formula

```text
TIME = Seconds × 1000 ms
```

---

# Logic

```text
IF Seconds <= 0 THEN
    Return := T#0S;
ELSE
    Return := DINT_TO_TIME(Seconds * 1000);
END_IF;
```

---

# Rules

- Negative values shall return `T#0S`.
- A value of zero shall return `T#0S`.
- The function shall not modify input parameters.
- The conversion shall be completed within a single PLC scan.
- Overflow protection shall be handled by the calling Function Block if extremely large values are possible.

---

# Return Value

| Input | Output |
|-------:|--------|
| -5 | T#0S |
| 0 | T#0S |
| 1 | T#1S |
| 30 | T#30S |
| 120 | T#2M |

---

# Typical Usage

- Recipe delay configuration
- Blower startup delay
- Dosing duration
- Alarm delay settings
- Communication timeout configuration
- Job scheduling parameters

---

# Used By

- FB_RecipeManager
- FB_Blower
- FB_Dosing
- FB_LineManager
- FB_SystemManager
- FB_JobManager

---

# Test Cases

| Seconds | Expected |
|----------:|----------|
| -10 | T#0S |
| 0 | T#0S |
| 1 | T#1S |
| 15 | T#15S |
| 60 | T#1M |
| 300 | T#5M |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function performs only the conversion between a numeric value expressed in seconds and the PLC `TIME` data type.

It does not:

- Start timers
- Stop timers
- Validate process timing
- Generate timeout conditions

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_IsTimeout.md
- FB_JobManager.md
- FB_Blower.md
- TEST_Functions.md

---

# Revision

Version 1.0