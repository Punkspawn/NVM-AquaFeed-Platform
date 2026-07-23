# Function

FN_CheckSelectorLimitState

---

# Function

FN_CheckSelectorLimitState

---

# Purpose

Checks the validity of selector position sensor states.

This function verifies that the selector position feedback signals represent a valid mechanical position.

The selector uses position sensors to determine its current mechanical location.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| Position1Sensor | BOOL | Position 1 sensor state |
| Position2Sensor | BOOL | Position 2 sensor state |
| Position3Sensor | BOOL | Position 3 sensor state |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | INT | Selector position state |

---

# Status Codes

| Value | Description |
|------:|-------------|
| 1 | Position 1 active |
| 2 | Position 2 active |
| 3 | Position 3 active |
| 0 | Invalid position state |

---

# Logic

```text
IF Position1Sensor = TRUE
AND Position2Sensor = FALSE
AND Position3Sensor = FALSE THEN

    Return := 1;

ELSIF Position1Sensor = FALSE
AND Position2Sensor = TRUE
AND Position3Sensor = FALSE THEN

    Return := 2;

ELSIF Position1Sensor = FALSE
AND Position2Sensor = FALSE
AND Position3Sensor = TRUE THEN

    Return := 3;

ELSE

    Return := 0;

END_IF;
```

---

# Rules

- Only one selector position sensor should be active at the same time.
- Multiple active sensors indicate invalid mechanical position.
- No active sensor indicates unknown position.
- The function shall only evaluate sensor states.
- The function shall not move the selector.
- The function shall not control motor outputs.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid position 1 | 1 |
| Valid position 2 | 2 |
| Valid position 3 | 3 |
| Invalid sensor combination | 0 |

---

# Typical Usage

- Selector position feedback
- Automatic feeding preparation
- Position safety verification
- Sequence permission control

---

# Used By

- FB_Selector
- FB_LineManager
- FB_Dosing
- FB_AlarmManager

---

# Test Cases

| P1 | P2 | P3 | Expected |
|----|----|----|----------|
| 0 | 0 | 0 | 0 |
| 1 | 0 | 0 | 1 |
| 0 | 1 | 0 | 2 |
| 0 | 0 | 1 | 3 |
| 1 | 1 | 0 | 0 |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function validates only selector sensor combinations.

It does not:

- Read physical inputs
- Filter sensor noise
- Control selector motor
- Perform movement sequence
- Detect mechanical damage

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CheckSelectorPosition.md
- FN_IsValidTransition.md
- FN_IsEquipmentReady.md
- FB_Selector.md

---

# Revision

Version 1.0