# FN_Ramp

---

# Purpose

Smoothly changes a value towards a target value by a defined step amount.

This function prevents sudden changes in analog values such as inverter speed, blower speed and dosing speed.

---

# Function

```iecst
FUNCTION FN_Ramp : REAL

VAR_INPUT

    CurrentValue : REAL;

    TargetValue  : REAL;

    Step         : REAL;

END_VAR

IF CurrentValue < TargetValue THEN

    FN_Ramp := CurrentValue + Step;

    IF FN_Ramp > TargetValue THEN
        FN_Ramp := TargetValue;
    END_IF;

ELSIF CurrentValue > TargetValue THEN

    FN_Ramp := CurrentValue - Step;

    IF FN_Ramp < TargetValue THEN
        FN_Ramp := TargetValue;
    END_IF;

ELSE

    FN_Ramp := CurrentValue;

END_IF;
```

---

# Inputs

CurrentValue

Current output value.

---

TargetValue

Desired target value.

---

Step

Maximum value change per PLC scan.

---

# Output

Returns the next ramped value.

---

# Example

```iecst
BlowerSpeed := FN_Ramp(
    CurrentValue := BlowerSpeed,
    TargetValue  := Recipe.BlowerSpeedPercent,
    Step         := 1.0
);
```

---

# Used By

- FB_Blower
- FB_Dosing
- FB_FeedingControlManager

---

# Rules

Step shall be greater than zero.

The function shall never overshoot the target.

The function shall always move toward the target value.

The function has no side effects.

Safe for execution every PLC scan.

---

# Typical Applications

- Inverter speed ramp
- Blower acceleration
- Blower deceleration
- Dosing speed transition
- Analog output smoothing