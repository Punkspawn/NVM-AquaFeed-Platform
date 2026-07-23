# Function

FN_CheckMotorOverloadCondition

---

# Function

FN_CheckMotorOverloadCondition

---

# Purpose

Evaluates the motor overload condition by comparing the measured motor current with the configured nominal current limit.

This function is used for blower motor protection monitoring and early detection of overload conditions.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| MotorCurrent | REAL | Measured motor current (A) |
| NominalCurrent | REAL | Motor nominal current limit (A) |
| OverloadPercentage | REAL | Allowed overload percentage (%) |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | INT | Overload status |

---

# Status Codes

| Value | Description |
|------:|-------------|
| 0 | Normal current |
| 1 | Overload detected |
| -1 | Invalid parameters |

---

# Formula

```text
MaximumAllowedCurrent =
NominalCurrent ×
(1 + OverloadPercentage / 100)
```

---

# Logic

```text
IF MotorCurrent < 0.0 THEN

    Return := -1;

ELSIF NominalCurrent <= 0.0 THEN

    Return := -1;

ELSIF OverloadPercentage < 0.0 THEN

    Return := -1;

ELSE

    MaximumAllowedCurrent :=
        NominalCurrent *
        (1.0 + OverloadPercentage / 100.0);


    IF MotorCurrent > MaximumAllowedCurrent THEN

        Return := 1;

    ELSE

        Return := 0;

    END_IF;

END_IF;
```

---

# Rules

- MotorCurrent shall be zero or greater.
- NominalCurrent shall be greater than zero.
- OverloadPercentage shall be zero or greater.
- The function shall prevent invalid parameter evaluation.
- Overload condition shall be reported when current exceeds the configured limit.
- The function shall execute within a single PLC scan.
- The function shall not modify input parameters.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Current within limit | 0 |
| Current exceeds limit | 1 |
| Invalid input parameters | -1 |

---

# Typical Usage

- Blower motor protection
- Pump motor monitoring
- Drive load supervision
- Equipment diagnostics
- Maintenance warning generation

---

# Used By

- FB_Blower
- FB_DiagnosticsManager
- FB_AlarmManager
- FB_HealthMonitor

---

# Test Cases

| Motor Current | Nominal Current | Overload | Expected |
|--------------:|----------------:|---------:|---------:|
| 10 A | 15 A | 10% | 0 |
| 16 A | 15 A | 10% | 1 |
| 20 A | 15 A | 20% | 1 |
| 5 A | 15 A | 10% | 0 |
| 10 A | 0 A | 10% | -1 |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function evaluates only motor current overload condition.

It does not:

- Trip the motor protection
- Stop the inverter
- Reset drive faults
- Read analog inputs
- Execute safety functions
- Control the blower

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CheckMotorRunningFeedback.md
- FN_IsEquipmentReady.md
- FN_IsTimeout.md
- FB_Blower.md
- FB_AlarmManager.md

---

# Revision

Version 1.0