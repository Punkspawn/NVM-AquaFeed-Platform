# Function

FN_CalculateDosageTime

---

# Function

FN_CalculateDosageTime

---

# Purpose

Calculates the required dosing operation time based on the target feed amount and the calibrated feeding rate.

This function is used by the dosing control system to determine how long the dosing motor should operate to deliver the required amount of feed.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| TargetAmount | REAL | Required feed amount (kg) |
| FeedRate | REAL | Calibrated feeding rate (kg/min) |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Required dosing time (minutes) |

---

# Formula

```text
DosageTime =
TargetAmount /
FeedRate
```

---

# Logic

```text
IF TargetAmount <= 0.0 THEN

    Return := 0.0;

ELSIF FeedRate <= 0.0 THEN

    Return := 0.0;

ELSE

    Return :=
        TargetAmount /
        FeedRate;

END_IF;
```

---

# Rules

- TargetAmount shall be greater than zero for a valid dosing operation.
- FeedRate shall be greater than zero.
- Division by zero shall be prevented.
- The returned time shall always be zero or greater.
- The function shall execute within a single PLC scan.
- The function shall not modify input parameters.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Required dosing time (min) |
| Zero target amount | 0.0 |
| Invalid feed rate | 0.0 |

---

# Typical Usage

- Automatic feeding cycle calculation
- Dosing motor runtime calculation
- Recipe execution
- Batch feeding operations
- Feed quantity control

---

# Used By

- FB_Dosing
- FB_FeedProgramManager
- FB_RecipeManager
- FB_LineManager

---

# Test Cases

| Target Amount | Feed Rate | Expected |
|--------------:|----------:|---------:|
| 100 kg | 10 kg/min | 10 min |
| 500 kg | 25 kg/min | 20 min |
| 250 kg | 50 kg/min | 5 min |
| 0 kg | 20 kg/min | 0 min |
| 100 kg | 0 kg/min | 0 min |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the required dosing duration.

It does not:

- Control the dosing motor
- Start or stop the dosing sequence
- Read sensors
- Perform calibration
- Validate recipe parameters
- Manage alarms

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateFeedAmount.md
- FN_CalculateFeedRate.md
- FN_CalculateCalibrationFactor.md
- FB_Dosing.md
- FB_FeedProgramManager.md

---

# Revision

Version 1.0