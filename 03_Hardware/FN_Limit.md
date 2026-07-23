# FN_Limit

---

# Purpose

Checks whether a value is within the specified range.

Unlike FN_Clamp, this function does not modify the value.
It only returns whether the value is valid.

---

# Function

```iecst
FUNCTION FN_Limit : BOOL

VAR_INPUT

    Value : REAL;

    MinValue : REAL;

    MaxValue : REAL;

END_VAR

IF (Value >= MinValue) AND (Value <= MaxValue) THEN

    FN_Limit := TRUE;

ELSE

    FN_Limit := FALSE;

END_IF;
```

---

# Inputs

Value

Value to validate.

---

MinValue

Minimum acceptable value.

---

MaxValue

Maximum acceptable value.

---

# Output

TRUE

Value is inside the permitted range.

FALSE

Value is outside the permitted range.

---

# Example

```iecst
IF NOT FN_Limit(
    Value:=Recipe.FeedAmountKg,
    MinValue:=0.5,
    MaxValue:=1000.0
) THEN

    AlarmCode := ALM_INVALID_FEED_AMOUNT;

END_IF;
```

---

# Used By

- FB_RecipeManager
- FB_FeedingControlManager
- FB_LineManager
- FB_SystemManager

---

# Rules

The function shall never modify the input value.

MinValue shall be less than or equal to MaxValue.

The function has no side effects.

Safe to execute every PLC scan.