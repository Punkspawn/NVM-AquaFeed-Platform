# FN_Clamp

---

# Purpose

Limits a value between a minimum and maximum range.

This function is used throughout the PLC project to prevent invalid values.

---

# Function

```iecst
FUNCTION FN_Clamp : REAL

VAR_INPUT

    Value : REAL;

    MinValue : REAL;

    MaxValue : REAL;

END_VAR

IF Value < MinValue THEN

    FN_Clamp := MinValue;

ELSIF Value > MaxValue THEN

    FN_Clamp := MaxValue;

ELSE

    FN_Clamp := Value;

END_IF;
```

---

# Inputs

Value

Value to be checked.

---

MinValue

Minimum allowed value.

---

MaxValue

Maximum allowed value.

---

# Output

Returns

Value limited between MinValue and MaxValue.

---

# Example

```iecst
MotorSpeed :=
FN_Clamp(
    Value:=MotorSpeed,
    MinValue:=0,
    MaxValue:=100
);
```

---

# Used By

- FB_Blower
- FB_Dosing
- FB_LineManager
- FB_RecipeManager
- FB_FeedingControlManager

---

# Rules

MinValue shall always be less than or equal to MaxValue.

If MinValue equals MaxValue, the function always returns that value.

The function contains no side effects.

Safe for repeated execution every PLC scan.