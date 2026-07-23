# FN_TimeToString

---

# Purpose

Converts a TIME value into a human-readable string.

This function is primarily intended for HMI and Desktop displays.

---

# Function

```iecst
FUNCTION FN_TimeToString : STRING[20]

VAR_INPUT

    TimeValue : TIME;

END_VAR

VAR

    TotalSeconds : DINT;

    Hours        : DINT;

    Minutes      : DINT;

    Seconds      : DINT;

END_VAR

TotalSeconds := TIME_TO_DINT(TimeValue) / 1000;

Hours := TotalSeconds / 3600;

Minutes := (TotalSeconds MOD 3600) / 60;

Seconds := TotalSeconds MOD 60;

FN_TimeToString :=
CONCAT(
    DINT_TO_STRING(Hours),
    ':'
);

FN_TimeToString :=
CONCAT(
    FN_TimeToString,
    DINT_TO_STRING(Minutes)
);

FN_TimeToString :=
CONCAT(
    FN_TimeToString,
    ':'
);

FN_TimeToString :=
CONCAT(
    FN_TimeToString,
    DINT_TO_STRING(Seconds)
);
```

---

# Inputs

TimeValue

TIME value to convert.

---

# Output

Returns

Time formatted as

HH:MM:SS

---

# Example

```iecst
DisplayTime :=
FN_TimeToString(
    Runtime.TotalProductionTime
);
```

Example Result

```text
01:25:42
```

---

# Used By

- HMI
- AquaFeed Manager
- Reports
- Runtime Screen
- Maintenance Screen

---

# Rules

Input shall be a valid TIME value.

The function shall not modify any global variables.

The function has no side effects.

Safe for repeated execution.

---

# Typical Applications

- Runtime display
- Maintenance hours
- Feeding duration
- Alarm duration
- Job execution time