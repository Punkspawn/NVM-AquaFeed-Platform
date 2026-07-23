# Function

FN_ConvertFrequencyToFlowRate

---

# Function

FN_ConvertFrequencyToFlowRate

---

# Purpose

Converts the dosing motor drive frequency value into an estimated feed flow rate.

This function is used to calculate the delivered feed capacity based on the motor drive operating frequency and calibrated flow characteristics.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| Frequency | REAL | Motor drive output frequency (Hz) |
| MaxFrequency | REAL | Maximum calibrated operating frequency (Hz) |
| MaxFlowRate | REAL | Maximum feed flow rate at MaxFrequency (kg/min) |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Estimated feed flow rate (kg/min) |

---

# Formula

```text
FlowRate =
(Frequency /
MaxFrequency)
×
MaxFlowRate
```

---

# Logic

```text
IF Frequency <= 0.0 THEN

    Return := 0.0;

ELSIF MaxFrequency <= 0.0 THEN

    Return := 0.0;

ELSIF MaxFlowRate <= 0.0 THEN

    Return := 0.0;

ELSE

    Return :=
        (Frequency / MaxFrequency)
        *
        MaxFlowRate;

END_IF;
```

---

# Rules

- Frequency shall be zero or greater.
- MaxFrequency shall be greater than zero.
- MaxFlowRate shall be greater than zero.
- Division by zero shall be prevented.
- The returned flow rate shall always be zero or greater.
- The function shall execute within a single PLC scan.
- The function shall not modify input parameters.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Estimated flow rate (kg/min) |
| Motor stopped | 0.0 |
| Invalid parameters | 0.0 |

---

# Typical Usage

- Dosing motor control
- Delta drive speed monitoring
- Feed rate calculation
- Automatic dosing compensation
- Production statistics

---

# Used By

- FB_Dosing
- FB_FeedProgramManager
- FB_RecipeManager
- FB_StatisticsManager

---

# Test Cases

| Frequency | Max Frequency | Max Flow | Expected |
|----------:|--------------:|---------:|---------:|
| 0 Hz | 50 Hz | 25 kg/min | 0 kg/min |
| 25 Hz | 50 Hz | 25 kg/min | 12.5 kg/min |
| 50 Hz | 50 Hz | 25 kg/min | 25 kg/min |
| 40 Hz | 50 Hz | 30 kg/min | 24 kg/min |
| 10 Hz | 0 Hz | 25 kg/min | 0 kg/min |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the estimated feed flow rate.

It does not:

- Control the drive frequency
- Communicate with the inverter
- Measure actual feed quantity
- Perform calibration
- Detect motor faults
- Generate alarms

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateFeedRate.md
- FN_CalculateCalibrationFactor.md
- FN_CalculateDosageTime.md
- FB_Dosing.md
- FB_Blower.md

---

# Revision

Version 1.0