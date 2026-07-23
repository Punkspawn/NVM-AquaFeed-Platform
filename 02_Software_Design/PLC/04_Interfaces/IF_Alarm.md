# IF_Alarm

---

# Purpose

Defines the standard software interface for alarm generation, acknowledgement and reset.

All PLC modules shall report alarms through this interface to ensure consistent alarm handling throughout the system.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| Enable | BOOL | Enables alarm monitoring. |
| AlarmTrigger | BOOL | Requests creation of an alarm. |
| AlarmCode | UINT | Alarm identification code. |
| Acknowledge | BOOL | Operator acknowledges the alarm. |
| Reset | BOOL | Clears the alarm if the fault condition no longer exists. |

---

# Outputs

| Name | Type | Description |
|------|------|-------------|
| Active | BOOL | Alarm is active. |
| Acknowledged | BOOL | Alarm has been acknowledged. |
| ResetRequired | BOOL | Alarm requires reset before operation can continue. |
| FaultPresent | BOOL | Fault condition is still present. |
| AlarmCode | UINT | Active alarm code. |

---

# State Flow

```text
Normal
    │
AlarmTrigger
    │
Active
    │
Acknowledge
    │
Acknowledged
    │
Reset
    │
Normal
```

Persistent fault

```text
Active
    │
Reset
    │
Fault Present
    │
Active
```

---

# Rules

- Every active alarm shall have a valid `AlarmCode`.
- Alarm acknowledgement shall not clear the fault condition.
- Reset shall only succeed when the fault condition has been removed.
- Multiple modules may generate alarms simultaneously.
- Alarm history shall not be deleted by a reset.

---

# Used By

- FB_AlarmManager
- FB_LineManager
- FB_Selector
- FB_Blower
- FB_Dosing
- FB_FeedingControlManager
- HMI
- AquaFeed Manager