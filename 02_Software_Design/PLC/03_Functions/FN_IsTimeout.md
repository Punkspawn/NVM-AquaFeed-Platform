# Function

FN_IsTimeout

---

# Purpose

Determines whether a timeout condition has occurred by comparing the elapsed time with the configured timeout limit.

This function provides a standardized timeout evaluation method for all equipment and communication modules.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| ElapsedTime | TIME | Elapsed operation time |
| TimeoutLimit | TIME | Configured timeout limit |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | BOOL | TRUE if timeout has occurred |

---

# Logic

```text
IF ElapsedTime >= TimeoutLimit THEN
    Return := TRUE;
ELSE
    Return := FALSE;
END_IF;
```

---

# Rules

- TimeoutLimit shall be greater than zero.
- Equality with the timeout limit is considered a timeout.
- Negative or invalid time values shall not be used.
- The function shall not modify any input values.
- The function shall execute deterministically within a single PLC scan.

---

# Return Value

| Condition | Return |
|-----------|--------|
| ElapsedTime < TimeoutLimit | FALSE |
| ElapsedTime ≥ TimeoutLimit | TRUE |

---

# Typical Usage

- Selector positioning timeout
- Blower startup timeout
- Dosing operation timeout
- Communication timeout
- Job execution timeout
- Initialization timeout

---

# Used By

- FB_Selector
- FB_Blower
- FB_Dosing
- FB_ModbusMaster
- FB_LineManager
- FB_SystemManager
- FB_JobManager

---

# Test Cases

| Elapsed | Limit | Expected |
|---------|-------|----------|
| T#5S | T#10S | FALSE |
| T#10S | T#10S | TRUE |
| T#15S | T#10S | TRUE |
| T#0S | T#5S | FALSE |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function only evaluates whether the timeout threshold has been reached.

It does not:

- Start or stop timers
- Generate alarms
- Reset timeout values
- Change equipment states

Timeout handling shall be performed by the calling Function Block.

---

# Related Documents

- FB_Selector.md
- FB_Blower.md
- FB_Dosing.md
- FB_ModbusMaster.md
- TEST_Functions.md

---

# Revision

Version 1.0