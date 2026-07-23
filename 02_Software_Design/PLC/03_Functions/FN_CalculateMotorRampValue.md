# Function

FN_CalculateMotorRampValue

---

# Function

FN_CalculateMotorRampValue

---

# Purpose

Calculates the required motor frequency change value during acceleration or deceleration according to the configured ramp time.

This function is used for controlled blower motor startup and stopping operations to prevent mechanical stress and excessive current peaks.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| CurrentFrequency | REAL | Current motor frequency (Hz) |
| TargetFrequency | REAL | Requested motor frequency (Hz) |
| RampTime | REAL | Configured ramp duration (seconds) |
| CycleTime | REAL | PLC execution cycle time (seconds) |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Frequency change value per PLC cycle (Hz) |

---

# Formula

```text
FrequencyStep =
(TargetFrequency - CurrentFrequency)
/
(RampTime / CycleTime)
```

---

# Logic

```text
IF RampTime <= 0.0 THEN

    Return := TargetFrequency - CurrentFrequency;

ELSIF CycleTime <= 0.0 THEN

    Return := 0.0;

ELSE

    Return :=
        (TargetFrequency - CurrentFrequency)
        /
        (RampTime / CycleTime);

END_IF;
```

---

# Rules

- RampTime shall be greater than zero for controlled ramp operation.
- CycleTime shall be greater than zero.
- The function shall support both acceleration and deceleration.
- Positive result indicates frequency increase.
- Negative result indicates frequency decrease.
- Division by zero shall be prevented.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Acceleration required | Positive Hz step |
| Deceleration required | Negative Hz step |
| Immediate change requested | Full frequency difference |
| Invalid cycle time | 0.0 |

---

# Typical Usage

- Blower startup sequence
- Motor soft acceleration
- Controlled stopping
- Drive frequency management
- Mechanical stress reduction

---

# Used By

- FB_Blower
- FB_LineManager
- FB_SystemManager
- FB_RecoveryManager

---

# Test Cases

| Current | Target | Ramp | Cycle | Expected |
|--------:|-------:|-----:|------:|---------:|
| 0 Hz | 50 Hz | 10 s | 0.1 s | 0.5 Hz |
| 20 Hz | 50 Hz | 5 s | 0.1 s | 0.6 Hz |
| 50 Hz | 0 Hz | 10 s | 0.1 s | -0.5 Hz |
| 0 Hz | 50 Hz | 0 s | 0.1 s | 50 Hz |
| 0 Hz | 50 Hz | 10 s | 0 s | 0 Hz |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the frequency change step.

It does not:

- Write frequency commands to the drive
- Control motor start/stop
- Monitor motor current
- Detect overload conditions
- Execute safety functions

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_ConvertFrequencyToAirFlow.md
- FN_LimitValue.md
- FB_Blower.md
- FB_RecoveryManager.md

---

# Revision

Version 1.0