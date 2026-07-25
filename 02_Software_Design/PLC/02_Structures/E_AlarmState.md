# E_AlarmState

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime / AquaCore |
| Version | 1.0 |

## Definition

```iecst
TYPE E_AlarmState :
(
    ALARM_INACTIVE,
    ALARM_ACTIVE_UNACKNOWLEDGED,
    ALARM_ACTIVE_ACKNOWLEDGED,
    ALARM_CLEARED_WAIT_RESET
);
END_TYPE
```

## Lifecycle

```text
Inactive
  ↓ condition active
Active Unacknowledged
  ↓ acknowledge
Active Acknowledged
  ↓ condition removed, manual reset required
Cleared Wait Reset
  ↓ valid reset
Inactive
```

For catalog entries configured for automatic clear, condition removal transitions directly to Inactive after a clear event is published.
