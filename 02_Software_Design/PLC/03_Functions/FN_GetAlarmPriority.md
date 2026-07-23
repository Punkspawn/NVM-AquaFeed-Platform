# Function

FN_GetAlarmPriority

---

# Purpose

Determines the priority level of an alarm based on its alarm class.

This function provides a standardized priority classification for alarm handling, HMI visualization, event logging, and alarm sorting throughout the AquaFeed Platform.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| AlarmClass | UINT | Alarm classification code |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | UINT | Alarm priority level |

---

# Priority Levels

| Value | Priority |
|------:|----------|
| 0 | None |
| 1 | Information |
| 2 | Warning |
| 3 | Critical |
| 4 | Emergency |

---

# Logic

```text
CASE AlarmClass OF

ALARM_INFO:
    Return := 1;

ALARM_WARNING:
    Return := 2;

ALARM_CRITICAL:
    Return := 3;

ALARM_EMERGENCY:
    Return := 4;

ELSE
    Return := 0;

END_CASE;
```

---

# Rules

- Every alarm class shall map to exactly one priority.
- Unknown alarm classes shall return priority **0**.
- The function shall not modify input values.
- The function shall execute within a single PLC scan.
- No persistent variables shall be used.

---

# Return Value

| Alarm Class | Priority |
|--------------|----------|
| Information | 1 |
| Warning | 2 |
| Critical | 3 |
| Emergency | 4 |
| Unknown | 0 |

---

# Typical Usage

- Alarm banner sorting
- Alarm history
- HMI color selection
- Alarm acknowledgment logic
- Event logging
- Remote monitoring

---

# Used By

- FB_AlarmManager
- FB_HMIManager
- FB_ReportManager
- FB_SystemManager
- FB_EventLogger

---

# Test Cases

| Alarm Class | Expected Priority |
|--------------|------------------|
| Information | 1 |
| Warning | 2 |
| Critical | 3 |
| Emergency | 4 |
| Undefined | 0 |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function only classifies the priority of an alarm.

It does not:

- Generate alarms
- Acknowledge alarms
- Reset alarms
- Log alarm events
- Notify operators

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FB_AlarmManager.md
- FB_HMIManager.md
- FB_EventLogger.md
- TEST_Functions.md

---

# Revision

Version 1.0