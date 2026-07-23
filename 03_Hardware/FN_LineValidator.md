# FN_LineValidator

---

# Purpose

Validates whether a feeding line is ready for operation.

The function prevents starting a feeding cycle when the selected line is unavailable or in an invalid state.

---

# Function

```iecst
FUNCTION FN_LineValidator : BOOL

VAR_INPUT

    Line : ST_Line;

END_VAR

FN_LineValidator := TRUE;

IF NOT Line.Enabled THEN
    FN_LineValidator := FALSE;
END_IF;

IF Line.Fault THEN
    FN_LineValidator := FALSE;
END_IF;

IF Line.Busy THEN
    FN_LineValidator := FALSE;
END_IF;

IF NOT Line.Ready THEN
    FN_LineValidator := FALSE;
END_IF;
```

---

# Inputs

Line

Feeding line structure.

---

# Output

TRUE

The feeding line is available for operation.

FALSE

The feeding line cannot be used.

---

# Validation Rules

The function checks

- Line Enabled
- Line Ready
- No Active Fault
- Not Busy

---

# Example

```iecst
IF FN_LineValidator(Line := Lines[SelectedLine]) THEN

    StartFeeding := TRUE;

ELSE

    AlarmCode := ALM_LINE_NOT_READY;

END_IF;
```

---

# Used By

- FB_LineManager
- FB_FeedingControlManager
- FB_SchedulerManager
- AquaFeed Manager

---

# Rules

The function shall never modify the Line structure.

Validation shall complete within one PLC scan.

The function contains no side effects.

---

# Future Validation

Additional validation rules may include

- Selector position verified
- Blower available
- Dosing unit available
- Communication status
- Maintenance lock
- Operator permission