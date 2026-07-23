# Function

FN_CalculateCalibrationFactor

---

# Function

FN_CalculateCalibrationFactor

---

# Purpose

Calculates the calibration correction factor by comparing the actual measured feed amount with the expected feed amount.

This function is used to compensate mechanical differences, wear, slip, and measurement errors in the dosing system.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| ExpectedAmount | REAL | Expected feed amount according to system calculation (kg) |
| MeasuredAmount | REAL | Actual measured feed amount during calibration (kg) |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Calibration correction factor |

---

# Formula

```text
CalibrationFactor =
MeasuredAmount /
ExpectedAmount
```

---

# Logic

```text
IF ExpectedAmount <= 0.0 THEN

    Return := 1.0;

ELSIF MeasuredAmount <= 0.0 THEN

    Return := 1.0;

ELSE

    Return :=
        MeasuredAmount /
        ExpectedAmount;

END_IF;
```

---

# Rules

- ExpectedAmount shall be greater than zero.
- MeasuredAmount shall be greater than zero.
- Division by zero shall be prevented.
- The correction factor shall normally be close to 1.0.
- A value below 1.0 indicates overestimation by the system.
- A value above 1.0 indicates underestimation by the system.
- The function shall execute within a single PLC scan.
- The function shall not modify input parameters.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid calibration | Correction factor |
| Invalid expected amount | 1.0 |
| Invalid measured amount | 1.0 |

---

# Typical Usage

- Dosing system calibration
- Feed motor compensation
- Recipe accuracy improvement
- Periodic service calibration
- Mechanical wear compensation

---

# Used By

- FB_Dosing
- FB_ServiceManager
- FB_CalibrationManager
- FB_RecipeManager

---

# Test Cases

| Expected Amount | Measured Amount | Expected Factor |
|----------------:|----------------:|----------------:|
| 100 kg | 100 kg | 1.00 |
| 100 kg | 95 kg | 0.95 |
| 100 kg | 105 kg | 1.05 |
| 500 kg | 490 kg | 0.98 |
| 0 kg | 100 kg | 1.00 |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the calibration correction factor.

It does not:

- Start calibration procedure
- Control dosing motor
- Save calibration parameters
- Read weighing sensors
- Validate mechanical components
- Apply the factor automatically

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateKgPerPulse.md
- FN_CalculatePulsePerKg.md
- FN_CalculateFeedAccuracy.md
- FB_Dosing.md
- FB_ServiceManager.md

---

# Revision

Version 1.0