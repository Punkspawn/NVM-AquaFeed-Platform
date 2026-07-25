# E_AlarmSeverity

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime / AquaCore |
| Version | 1.0 |

## Definition

```iecst
TYPE E_AlarmSeverity :
(
    ALARM_INFORMATION,
    ALARM_WARNING,
    ALARM_FAULT,
    ALARM_CRITICAL,
    ALARM_EMERGENCY
);
END_TYPE
```

## Rules

- Information never blocks production.
- Warning normally permits production unless a separate approved interlock acts.
- Fault may block the affected device or line.
- Critical normally requires controlled stop of the affected scope.
- Emergency reflects an approved emergency/safety condition and has highest display priority.
- Severity itself never writes outputs; SystemManager, LineManager, equipment logic, and hardwired safety own actions.
