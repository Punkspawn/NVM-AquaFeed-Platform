# Function

FN_ConvertFrequencyToAirFlow

---

# Function

FN_ConvertFrequencyToAirFlow

---

# Purpose

Converts blower motor drive frequency into estimated air flow value.

This function is used to calculate the expected blower air capacity based on inverter frequency and blower calibration data.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| Frequency | REAL | Blower drive output frequency (Hz) |
| MaximumFrequency | REAL | Maximum calibrated frequency (Hz) |
| MaximumAirFlow | REAL | Maximum air flow at maximum frequency (m³/h) |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Estimated air flow (m³/h) |

---

# Formula

```text
AirFlow =
(Frequency /
MaximumFrequency)
×
MaximumAirFlow
```

---

# Logic

```text
IF Frequency <= 0.0 THEN

    Return := 0.0;

ELSIF MaximumFrequency <= 0.0 THEN

    Return := 0.0;

ELSIF MaximumAirFlow <= 0.0 THEN

    Return := 0.0;

ELSE

    Return :=
        (Frequency / MaximumFrequency)
        *
        MaximumAirFlow;

END_IF;
```

---

# Rules

- Frequency shall be zero or greater.
- MaximumFrequency shall be greater than zero.
- MaximumAirFlow shall be greater than zero.
- Division by zero shall be prevented.
- The returned airflow value shall always be zero or greater.
- The function shall execute within a single PLC scan.
- The function shall not modify input parameters.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Air flow (m³/h) |
| Blower stopped | 0.0 |
| Invalid parameters | 0.0 |

---

# Typical Usage

- Blower performance monitoring
- Air supply calculation
- Feed line pressure support
- Energy optimization
- System diagnostics

---

# Used By

- FB_Blower
- FB_LineManager
- FB_HealthMonitor
- FB_StatisticsManager

---

# Test Cases

| Frequency | Max Frequency | Max Air Flow | Expected |
|----------:|--------------:|-------------:|---------:|
| 0 Hz | 50 Hz | 1000 m³/h | 0 |
| 25 Hz | 50 Hz | 1000 m³/h | 500 |
| 50 Hz | 50 Hz | 1000 m³/h | 1000 |
| 40 Hz | 50 Hz | 1500 m³/h | 1200 |
| 10 Hz | 0 Hz | 1000 m³/h | 0 |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only estimated airflow.

It does not:

- Control blower speed
- Communicate with inverter
- Read pressure sensors
- Start or stop blower
- Generate alarms
- Execute protection logic

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateFeedRate.md
- FN_ConvertFrequencyToFlowRate.md
- FB_Blower.md
- FB_LineManager.md

---

# Revision

Version 1.0