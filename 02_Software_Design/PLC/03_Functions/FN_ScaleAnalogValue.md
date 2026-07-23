# Function

FN_ScaleAnalogValue

---

# Purpose

Converts a raw analog input value into an engineering unit using linear scaling.

This function provides a consistent method for translating PLC analog values into meaningful engineering values such as pressure, temperature, current, level, or speed.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| RawValue | REAL | Measured raw analog value |
| RawMin | REAL | Minimum raw input value |
| RawMax | REAL | Maximum raw input value |
| EngMin | REAL | Minimum engineering value |
| EngMax | REAL | Maximum engineering value |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Scaled engineering value |

---

# Formula

```text
ScaledValue =
((RawValue - RawMin)
/
(RawMax - RawMin))
×
(EngMax - EngMin)
+
EngMin
```

---

# Logic

```text
IF RawMax = RawMin THEN
    Return := EngMin;
ELSE
    Return :=
        ((RawValue - RawMin) /
        (RawMax - RawMin))
        *
        (EngMax - EngMin)
        +
        EngMin;
END_IF;
```

---

# Rules

- RawMax shall be greater than RawMin.
- Engineering limits may be increasing or decreasing.
- Division by zero shall be prevented.
- The function shall not modify input parameters.
- The calculation shall complete within a single PLC scan.

---

# Return Value

| Condition | Result |
|-----------|--------|
| Valid scaling | Engineering value |
| Invalid raw range | EngMin |

---

# Typical Usage

- Pressure transmitter scaling
- Tank level measurement
- Temperature sensor conversion
- Current measurement
- Motor speed feedback
- Analog output scaling

---

# Used By

- FB_AnalogInput
- FB_Blower
- FB_Dosing
- FB_SystemManager
- FB_HMIManager

---

# Test Cases

| Raw | Raw Min | Raw Max | Eng Min | Eng Max | Expected |
|----:|---------:|---------:|---------:|---------:|---------:|
| 0 | 0 | 27648 | 0 | 100 | 0 |
| 13824 | 0 | 27648 | 0 | 100 | 50 |
| 27648 | 0 | 27648 | 0 | 100 | 100 |
| 5529.6 | 0 | 27648 | 0 | 20 | 4 |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function performs only linear scaling.

It does not:

- Filter noisy signals
- Validate sensor health
- Detect wire breaks
- Clamp output values
- Generate alarms

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_LimitValue.md
- FN_CheckRange.md
- FB_AnalogInput.md
- TEST_Functions.md

---

# Revision

Version 1.0