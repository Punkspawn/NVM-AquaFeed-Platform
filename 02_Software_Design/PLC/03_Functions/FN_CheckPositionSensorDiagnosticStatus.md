# Function

FN_CheckPositionSensorDiagnosticStatus

---

# Function

FN_CheckPositionSensorDiagnosticStatus

---

# Purpose

Evaluates the diagnostic status of position sensor feedback signals.

This function checks whether the position feedback information is valid for equipment position determination.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| SensorFeedbackValid | BOOL | Position sensor feedback validity |
| MultiplePositionDetected | BOOL | Multiple position signals detected |
| PositionDetected | BOOL | Valid position detected |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | INT | Sensor diagnostic status |

---

# Status Codes

| Value | Description |
|------:|-------------|
| 0 | INVALID |
| 1 | NO POSITION |
| 2 | VALID |

---

# Logic

```text
IF SensorFeedbackValid = FALSE THEN

    Return := 0;

ELSIF MultiplePositionDetected = TRUE THEN

    Return := 0;

ELSIF PositionDetected = FALSE THEN

    Return := 1;

ELSE

    Return := 2;

END_IF;
```

---

# Rules

- Position feedback shall be considered valid only when sensor information is consistent.
- Multiple position detection shall be treated as invalid feedback.
- Missing position information shall be reported separately.
- The function shall only evaluate sensor diagnostic status.
- The function shall not control sensor inputs.
- The function shall not move equipment.
- The function shall not generate alarms directly.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Invalid sensor feedback | 0 |
| No position detected | 1 |
| Valid position feedback | 2 |

---

# Typical Usage

- Selector diagnostics
- Position feedback monitoring
- Equipment health status
- Fault detection support

---

# Used By

- FB_DiagnosticsManager
- FB_Selector
- FB_AlarmManager
- FB_HealthMonitor

---

# Test Cases

| Valid | Multiple | Position | Expected |
|------|----------|----------|----------|
| FALSE | FALSE | FALSE | 0 |
| TRUE | TRUE | TRUE | 0 |
| TRUE | FALSE | FALSE | 1 |
| TRUE | FALSE | TRUE | 2 |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function evaluates only position sensor diagnostic information.

It does not:

- Read physical inputs
- Filter sensor signals
- Control selector movement
- Reset faults
- Generate alarms

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CheckSelectorSensorConsistency.md
- FN_CheckSelectorPosition.md
- FB_DiagnosticsManager.md

---

# Revision

Version 1.0