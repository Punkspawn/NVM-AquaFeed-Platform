# Function

FN_CheckWarningCondition

---

# Function

FN_CheckWarningCondition

---

# Purpose

Evaluates warning conditions and determines whether a non-critical warning is active.

This function separates warning conditions from fault conditions to provide proper operator information.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| MaintenanceWarning | BOOL | Maintenance related warning status |
| ParameterWarning | BOOL | Parameter limit warning status |
| CommunicationWarning | BOOL | Communication quality warning status |
| ProcessWarning | BOOL | Process condition warning status |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | BOOL | Warning active status |

---

# Logic

```text
IF MaintenanceWarning = TRUE THEN

    Return := TRUE;

ELSIF ParameterWarning = TRUE THEN

    Return := TRUE;

ELSIF CommunicationWarning = TRUE THEN

    Return := TRUE;

ELSIF ProcessWarning = TRUE THEN

    Return := TRUE;

ELSE

    Return := FALSE;

END_IF;
```

---

# Rules

- Warning conditions shall not represent critical failures.
- Any active warning condition shall result in warning status.
- Warning evaluation shall be independent from fault evaluation.
- The function shall only combine warning conditions.
- The function shall not stop equipment.
- The function shall not create alarm records.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Any warning active | TRUE |
| No warning active | FALSE |

---

# Typical Usage

- Operator information
- HMI warning display
- Maintenance notifications
- System monitoring

---

# Used By

- FB_AlarmManager
- FB_DiagnosticsManager
- FB_HMIManager
- FB_MaintenanceManager

---

# Test Cases

| Maintenance | Parameter | Communication | Process | Expected |
|------------|-----------|---------------|---------|----------|
| FALSE | FALSE | FALSE | FALSE | FALSE |
| TRUE | FALSE | FALSE | FALSE | TRUE |
| FALSE | TRUE | FALSE | FALSE | TRUE |
| FALSE | FALSE | TRUE | FALSE | TRUE |
| FALSE | FALSE | FALSE | TRUE | TRUE |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function evaluates only warning conditions.

It does not:

- Generate alarm messages
- Assign alarm priority
- Store warning history
- Control equipment
- Reset warnings

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CheckFaultCondition.md
- FN_CheckAlarmPriority.md
- FN_IsAlarmActive.md
- FB_AlarmManager.md

---

# Revision

Version 1.0