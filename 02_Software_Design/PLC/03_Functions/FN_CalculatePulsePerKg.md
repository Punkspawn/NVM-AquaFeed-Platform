# Function

FN_CalculatePulsePerKg

---

# Function

FN_CalculatePulsePerKg

---

# Purpose

Calculates the number of encoder or counter pulses required to deliver one kilogram of feed.

This function is used for dosing system calibration and precise feed quantity control.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| CalibrationAmount | REAL | Known feed amount used during calibration (kg) |
| PulseCount | DINT | Total pulse count measured during calibration |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Pulse count per kilogram (pulse/kg) |

---

# Formula

```text
PulsePerKg =
PulseCount /
CalibrationAmount
```

---

# Logic

```text
IF CalibrationAmount <= 0.0 THEN

    Return := 0.0;

ELSIF PulseCount <= 0 THEN

    Return := 0.0;

ELSE

    Return :=
        REAL(PulseCount)
        /
        CalibrationAmount;

END_IF;
```

---

# Rules

- CalibrationAmount shall be greater than zero.
- PulseCount shall be greater than zero.
- Division by zero shall be prevented.
- The returned value represents required pulses for one kilogram of feed.
- The function shall execute within a single PLC scan.
- The function shall not modify input parameters.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid calibration | Pulse/kg value |
| Invalid calibration amount | 0.0 |
| Invalid pulse count | 0.0 |

---

# Typical Usage

- Dosing motor calibration
- Encoder based quantity control
- Pulse counter scaling
- Accurate feed measurement
- Batch dosing applications

---

# Used By

- FB_Dosing
- FB_ServiceManager
- FB_CalibrationManager
- FB_FeedProgramManager

---

# Test Cases

| Calibration Amount | Pulse Count | Expected |
|-------------------:|------------:|---------:|
| 100 kg | 10000 | 100 pulse/kg |
| 50 kg | 5000 | 100 pulse/kg |
| 250 kg | 12500 | 50 pulse/kg |
| 0 kg | 1000 | 0 pulse/kg |
| 100 kg | 0 | 0 pulse/kg |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only pulse conversion ratio.

It does not:

- Read encoder signals
- Count hardware pulses
- Control dosing motor
- Save calibration parameters
- Execute calibration sequence
- Validate mechanical operation

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateKgPerPulse.md
- FN_CalculateCalibrationFactor.md
- FN_CalculateDosageTime.md
- FB_Dosing.md
- FB_ServiceManager.md

---

# Revision

Version 1.0