# Function

FN_CalculateRuntimeSeconds

---

# Function

FN_CalculateRuntimeSeconds

---

# Purpose

Calculates the runtime duration in seconds based on an active operating condition.

This function is used to calculate equipment operating time for monitoring and logging purposes.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| RuntimeActive | BOOL | Runtime counting enable condition |
| CycleTime | REAL | PLC cycle time (seconds) |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Runtime increment value (seconds) |

---

# Formula

```text
RuntimeIncrement =
CycleTime
```

when:

```text
RuntimeActive = TRUE
```

---

# Logic

```text
IF RuntimeActive = TRUE THEN

    Return := CycleTime;

ELSE

    Return := 0.0;

END_IF;
```

---

# Rules

- Runtime shall increase only when the equipment operation condition is active.
- Runtime calculation shall use PLC cycle time.
- The function shall only calculate the increment value.
- The function shall not store total runtime.
- The function shall not access persistent memory.
- The function shall execute within a single PLC scan.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Equipment running | Cycle time value |
| Equipment stopped | 0.0 |

---

# Typical Usage

- Blower runtime tracking
- Dosing motor runtime tracking
- Selector movement duration
- Line operation statistics

---

# Used By

- FB_DataLogger
- FB_StatisticsManager
- FB_MaintenanceManager

---

# Test Cases

| Active | Cycle Time | Expected |
|--------|------------|----------|
| FALSE | 0.1 s | 0.0 |
| TRUE | 0.1 s | 0.1 |
| TRUE | 1.0 s | 1.0 |
| FALSE | 1.0 s | 0.0 |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only runtime increment.

It does not:

- Store accumulated runtime
- Save data permanently
- Create maintenance records
- Generate reports

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateRuntimeHours.md
- FN_CheckLogTrigger.md
- FB_DataLogger.md

---

# Revision

Version 1.0