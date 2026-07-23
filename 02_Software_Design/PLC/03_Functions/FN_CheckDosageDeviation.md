# Function

FN_CheckDosageDeviation

---

# Function

FN_CheckDosageDeviation

---

# Purpose

Checks the deviation between the target feed amount and the actual delivered feed amount.

This function is used by the dosing control system to determine whether the completed dosing operation is within acceptable tolerance limits.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| TargetAmount | REAL | Required feed amount (kg) |
| ActualAmount | REAL | Measured delivered feed amount (kg) |
| AllowedDeviation | REAL | Maximum allowed deviation (%) |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | INT | Dosage deviation status |

---

# Status Codes

| Value | Description |
|------:|-------------|
| 0 | OK - Within tolerance |
| 1 | LOW - Delivered amount below target |
| 2 | HIGH - Delivered amount above target |
| -1 | Invalid input |

---

# Formula

```text
DeviationPercentage =
((ActualAmount - TargetAmount) /
TargetAmount)
× 100
```

---

# Logic

```text
IF TargetAmount <= 0.0 THEN

    Return := -1;

ELSIF AllowedDeviation < 0.0 THEN

    Return := -1;

ELSE

    Deviation :=
        ((ActualAmount - TargetAmount)
        /
        TargetAmount)
        * 100.0;


    IF Deviation > AllowedDeviation THEN

        Return := 2;

    ELSIF Deviation < -AllowedDeviation THEN

        Return := 1;

    ELSE

        Return := 0;

    END_IF;

END_IF;
```

---

# Rules

- TargetAmount shall be greater than zero.
- ActualAmount shall be zero or greater.
- AllowedDeviation shall be zero or greater.
- Negative tolerance values shall not be accepted.
- Division by zero shall be prevented.
- The function shall execute within a single PLC scan.
- The function shall not modify input parameters.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Actual amount within tolerance | 0 |
| Actual amount below target | 1 |
| Actual amount above target | 2 |
| Invalid parameters | -1 |

---

# Typical Usage

- Automatic dosing verification
- Batch feeding control
- Calibration validation
- Recipe execution monitoring
- Feed accuracy monitoring

---

# Used By

- FB_Dosing
- FB_FeedProgramManager
- FB_RecipeManager
- FB_StatisticsManager

---

# Test Cases

| Target | Actual | Tolerance | Expected |
|-------:|-------:|----------:|---------:|
| 100 kg | 100 kg | 5% | 0 |
| 100 kg | 96 kg | 5% | 0 |
| 100 kg | 90 kg | 5% | 1 |
| 100 kg | 110 kg | 5% | 2 |
| 0 kg | 100 kg | 5% | -1 |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function only evaluates dosing deviation.

It does not:

- Measure actual feed quantity
- Read load cells
- Control dosing motor
- Stop dosing operation
- Generate alarms
- Store production history

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateFeedAccuracy.md
- FN_CalculateFeedVariance.md
- FN_CalculateCalibrationFactor.md
- FB_Dosing.md
- FB_AlarmManager.md

---

# Revision

Version 1.0